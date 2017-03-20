Return-Path: <arndbergmann@gmail.com>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20170320213600.GD20094@minitux>
References: <20170313160635.612251-1-arnd@arndb.de> <20170320213600.GD20094@minitux>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 20 Mar 2017 22:44:39 +0100
Message-ID: <CAK8P3a02A5KEMGkQBj=dW8ssjsNH0GcHY82sm1-CPZZdQV0oOA@mail.gmail.com>
Subject: Re: [RESEND PATCH] Bluetooth: btqcomsmd: fix compile-test dependency
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, Bjorn Andersson <bjorn.andersson@sonymobile.com>,
	Javier Martinez Canillas <javier@osg.samsung.com>, Loic Poulain <loic.poulain@intel.com>,
	linux-bluetooth@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Mar 20, 2017 at 10:36 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Mon 13 Mar 09:06 PDT 2017, Arnd Bergmann wrote:
>
>> compile-testing fails when QCOM_SMD is a loadable module:
>>
>> drivers/bluetooth/built-in.o: In function `btqcomsmd_send':
>> btqca.c:(.text+0xa8): undefined reference to `qcom_smd_send'
>> drivers/bluetooth/built-in.o: In function `btqcomsmd_probe':
>> btqca.c:(.text+0x3ec): undefined reference to `qcom_wcnss_open_channel'
>> btqca.c:(.text+0x46c): undefined reference to `qcom_smd_set_drvdata'
>>
>> This clarifies the dependency to allow compile-testing only when
>> SMD is completely disabled, otherwise the dependency on QCOM_SMD
>> will make sure we can link against it.
>>
>> Fixes: e27ee2b16bad ("Bluetooth: btqcomsmd: Allow driver to build if COMPILE_TEST is enabled")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
>
> Sorry for the slow response, wanted to make some test-builds before
> answering this.
>
> It's valid to set:
> COMPILE_TEST=y
> QCOM_SMD=y
> WCNSS_CTRL=m
> BT_QCOMSMD=y
>
> which will cause the qcom_wcnss_open_channel issue above to remain.
>
> For the wcn36xx driver we cover both with:
>         depends on QCOM_WCNSS_CTRL || QCOM_WCNSS_CTRL=n
>         depends on QCOM_SMD || QCOM_SMD=n
>
> The ath-maintainers  didn't want COMPILE_TEST due to some unrelated
> reasons, but I think it's better to express it in two statements, i.e.
>
>         depends on QCOM_WCNSS_CTRL || (COMPILE_TEST && QCOM_WCNSS_CTRL=n)
>         depends on QCOM_SMD || (COMPILE_TEST && QCOM_SMD=n)

Agreed, that looks cleaner. AFAICT the effect is the same as in my
version, as QCOM_WCNSS_CTRL is a tristate symbol and also
depends on QCOM_SMD (so QCOM_WCNSS_CTRL=y implies
QCOM_SMD=y, and QCOM_WCNSS_CTRL=m implies QCOM_SMD=(y||m).

Can you send the updated patch?

      Arnd

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <54F70642BAB21D4498E1AA3EFE3D519A45FC1E92@rsex2.realsil.com.cn>
References: <1404218878-14218-1-git-send-email-drake@endlessm.com>
	<16AC594D-6B3C-4CB6-B951-0763F3E4E27A@holtmann.org>
	<CAD8Lp45HbA03MycDVu6akTfEET_ZzxrwGpH1TbiQrw5Z178aeA@mail.gmail.com>
	<53B2D160.4010306@lwfinger.net>
	<F9E90F3A-5FE4-407C-833A-5E852A260984@holtmann.org>
	<54F70642BAB21D4498E1AA3EFE3D519A45FBED07@rsex2.realsil.com.cn>
	<B6A2794A-32D2-4D66-9D61-A27D7DA247B1@holtmann.org>
	<54F70642BAB21D4498E1AA3EFE3D519A45FBF299@rsex2.realsil.com.cn>
	<CAD8Lp44-=9RNWf2tfmCL14dWJRiZhGCtj042TprR7Q3m9hbNzA@mail.gmail.com>
	<54F70642BAB21D4498E1AA3EFE3D519A45FC1E92@rsex2.realsil.com.cn>
Date: Fri, 11 Jul 2014 10:11:35 +0100
Message-ID: <CAD8Lp44eaR3yMh6HUtwcMp1HRYBj-ec9+-FvSBJHyFh3WQstDg@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiBbUEFUQ0ggdjJdIEJsdWV0b290aDogYnR1c2I6IEFkZA==?=
	=?UTF-8?B?IFJlYWx0ZWsgODcyMy84NzYxIHN1cHBvcnQ=?=
From: Daniel Drake <drake@endlessm.com>
To: =?UTF-8?B?6ZmI6Imz6JCN?= <champion_chen@realsil.com.cn>
Cc: Marcel Holtmann <marcel@holtmann.org>, Larry Finger <Larry.Finger@lwfinger.net>,
	"Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Champion,

Thanks for the response - the situation is becoming clearer.

On Fri, Jul 11, 2014 at 9:44 AM, =E9=99=88=E8=89=B3=E8=90=8D <champion_chen=
@realsil.com.cn> wrote:
> Hi Daniel,
>         The 8761 module used with different wifi chip can only be disting=
uished by pid, and do not support vendor command to get information from ro=
m code.
> The setup function only has hci_dev parameter .
> we can add driver_info and set different setup funcitons. Will this be ac=
ceptable or do you have other suggestions?

I will have to discuss this with Marcel. He was not so keen on this
approach, but given that you have now clarified exactly what the
situation is (thanks!), we will have to revisit.

However, what is clear is that we will not add support for any
hardware where we do not also submit the firmware to the
linux-firmware git repository. At the moment we only have rtl8723a and
8723b firmware and configs:

rtl8723a_fw: 24356 bytes
md5sum b4a329212ab150b88c3c6ff4c42c51d6

rtl8723b_fw: 38976 bytes
md5sum ebf894b7b91cbebce8aeb5ba63c22914

These can be found at https://github.com/lwfinger/rtl8723au_bt/tree/new

We are missing all of the following:
rtl8821a_fw
rtl8761a_fw
rtl8761au_fw
rtl8761aw8192eu_fw
rtl8761au8192ee_fw
rtl8761au8812ae_fw
rtl8761a_config
rtl8821a_config

Please could you send them over, and confirm that all are redistributable?

About the config files, I am still not really clear if they are
necessary. You say the hardware will use default settings if they are
not provided. My RTL8723B does work fine without the config. What is
the advantage of uploading these config files then, have you
changed/improve the settings since production?

Thanks
Daniel

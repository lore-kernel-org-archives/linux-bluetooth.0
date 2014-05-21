Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140521131631.GA25779@t440s.P-661HNU-F1>
References: <1400676302-13626-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1400676302-13626-6-git-send-email-lukasz.rymanowski@tieto.com>
	<20140521131631.GA25779@t440s.P-661HNU-F1>
Date: Wed, 21 May 2014 16:10:01 +0200
Message-ID: <CAMudyAuRM29q_LPX63Bh2tpHS_S5h5toZoJu2MJQEXuOavpuzg@mail.gmail.com>
Subject: Re: [PATCH 05/12] android/bluetooth: Expose API to update sign counter
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Szymon Janc <szymon.janc@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 21 May 2014 15:16, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lukasz,
>
> On Wed, May 21, 2014, Lukasz Rymanowski wrote:
>> +void bt_update_sign_counter(const bdaddr_t *addr, bool local);
>
> This doesn't make for a good API since you can't know which counter
> bt_update_sign_counter(bdaddr, true/false) updates without looking at
> the actual implementation. Either create a two-value enum or have two
> separate functions to make the calling code more readable.
>

Ok, will add enum here.

> Johan

Thanks
Lukasz

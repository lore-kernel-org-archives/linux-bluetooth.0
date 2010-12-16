Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTim5y+g0n2-k8XMHE4kU-N-n-p4DvHVGg045Aoys@mail.gmail.com>
References: <1291989348-3911-1-git-send-email-michalski.raf@gmail.com>
	<AANLkTinVMvv9KG0oG1C=_wA6t7LhcYcCunuYGTWyn1Hs@mail.gmail.com>
	<AANLkTi=jaKy=o0MhzV6xRwyk00OxOhk302-DHXM7fEgE@mail.gmail.com>
	<20101214153405.GA11741@jh-x301>
	<1292341274.3050.15.camel@novo.hadess.net>
	<AANLkTimMOeuyUj5CRMsm7QpoumgHRMmOsby2E6GoSHrd@mail.gmail.com>
	<AANLkTim5y+g0n2-k8XMHE4kU-N-n-p4DvHVGg045Aoys@mail.gmail.com>
Date: Thu, 16 Dec 2010 11:28:28 +0200
Message-ID: <AANLkTik+R_pBHTjqmcHxOcz3VpNcBsefgbGbtD3iaOVr@mail.gmail.com>
Subject: Re: [PATCH] Fix crash while reading from mapped file
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Lukasz Pawlik <lucas.pawlik@gmail.com>,
	Bastien Nocera <hadess@hadess.net>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Dec 15, 2010 at 8:19 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> On Tue, Dec 14, 2010 at 2:20 PM, Lukasz Pawlik <lucas.pawlik@gmail.com> wrote:
>> Hi,
>>
>>> If somebody can explain what that code is supposed to do, then writing a
>>> glib-ish version should be trivial, without having to duplicate the
>>> contents again. Then again, using something like:
>>> g_mapped_file_new ();
>>> g_strsplit ();
>>> g_mapped_file_unref ();
>>
>> That won't fix anything since g_mapped_file_new uses mmap function so
>> contents may not be zero-terminated and we want use string function
>> next.
>
> What about using g_strstr_len() instead of strpbrk() on the original
> code? See http://library.gnome.org/devel/glib/unstable/glib-String-Utility-Functions.html#g-strstr-len

That looks to be a good replacement for strpbrk, probably 1 line patch.


-- 
Luiz Augusto von Dentz
Computer Engineer

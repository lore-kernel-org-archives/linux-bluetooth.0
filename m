Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH BlueZ] l2test: Set CID due to socket restrictions for LE
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20131017140019.GA361@x220.p-661hnu-f1>
Date: Thu, 17 Oct 2013 16:29:02 +0200
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <4DF07F65-8B30-42CA-809B-1F30440556BA@holtmann.org>
References: <1381950307-7155-1-git-send-email-claudio.takahasi@openbossa.org> <20131016203518.GA947@x220.p-661hnu-f1> <CAKT1EBcunESoPak7NhMmW6-r2n3QH8CyJgtg=9W3fXx6sjNmcg@mail.gmail.com> <20131017140019.GA361@x220.p-661hnu-f1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>>>> Bluetooth kernel now restricts LE L2CAP sockets to ATT channels only.
>>>> For LE L2CAP socket bind, ATT CID is now mandatory. Reference: kernel patch
>>>> bfe4655f05d7ec4a7c0c1c7e4051862f824cd8ec
>>>> ---
>>>> tools/l2test.c | 2 ++
>>>> 1 file changed, 2 insertions(+)
>>> 
>>> Applied thanks.
>>> 
>>> Btw, I didn't realize that this check wasn't there before. It seems like
>>> it shouldn't cause any "real life" issues as our btio has always done a
>>> bind with the correct CID. Can you confirm that this should only be an
>>> issue for l2test?
>>> 
>>> Johan
>> 
>> Yes. btio calls bind with the correct CID.
>> 
>> I suspect that the is another issue in bt_io_connect() call inside
>> device_browse_primary(),
>> the source address type is missing (it is mandatory now). I will send
>> a patch to fix it.
> 
> Good catch, though we'll likely need to fix this for the kernel too so
> that we don't end up with a kernel release that breaks old user space
> versions.

whoever talked to me about adding bdaddr_type over and over again, and then not bothered to fix this in userspace, needs to stand in a corner and think about it for a long time what he has done now.

I am not amused about this at all.

>> At some point we need to infer the adapter address type instead of
>> always use public address.
> 
> To be honest, selecting whether to use a random address when scanning or
> advertising doesn't at least immediately strike me as something that
> should be done through the bind call, but instead something that should
> be a global setting for the entire adapter. Having the exact LE address
> type in connect() makes sense, but not necessarily for bind().

It does make sense to have this. Userspace knows what it is doing. Right now it is pretty simple. Either you have a public address, then that is used. If you do not have a public, then you need to configure a static address first, and then that will be used. So you know the address type that is in use.

When adding support for privacy feature then this becomes a bit more complicated, but at all times, the userspace will know how it configured the kernel. Either use public address or use random address.

Regards

Marcel


Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAo+LNPUiKFLXKGrCMF8XghTonOMvJAomzy9jLGdJEkmzjWagA@mail.gmail.com>
References: <CAAo+LNOnDtHYjfLAQXj3Tgqiibd+oyKJP9109TfoGaDuAbmgag@mail.gmail.com>
	<CABBYNZLqxCSN6cViGY07e44C40i4Puvi7PqJtqhM6kDXWj_qaw@mail.gmail.com>
	<CAAo+LNPfXuE9+E2V3q5+m154GXTKuC6sbMVcuNWOB6K97vkytg@mail.gmail.com>
	<CAAo+LNMHzRLY0v_bZHYRqwSNiED74dmoovbisBOapuM=vB+WSg@mail.gmail.com>
	<CABBYNZKGwKEztXu1nV9cPNSNek66cAuMju=+Eaksu6YgFLt3gA@mail.gmail.com>
	<CAAo+LNPUiKFLXKGrCMF8XghTonOMvJAomzy9jLGdJEkmzjWagA@mail.gmail.com>
Date: Mon, 7 Mar 2016 23:19:20 +0300
Message-ID: <CAAo+LNPJeSD7Y_Fzk+rPuEwbbzXJEvkmSowVSY48-khczVefGA@mail.gmail.com>
Subject: Re: BTLE pairing sequence problem
From: Andrew - <hidefromkgb@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

OK guys, this last step (registering as a HID device) I managed to make myself.

The problem seems to be that the keyboard was being registered as a
pointer in XInput, again due to outdated config in /etc/xorg.conf.d
that defined everything in /dev/input/* as pointers unless explicitly
told not to.

Problem solved. Thank you so much!

2016-03-07 22:06 GMT+03:00, Andrew - <hidefromkgb@gmail.com>:
>> I think your problem start way before then
>
> Fair enough. There was an udev rule that enabled my bluetooth module
> manually, circumventing the standard procedure (suggested on Arch Wiki
> several years ago, obsolete by now).
> So now the rule`s gone so pairing and encryption complete
> successfully. First victory!
>
> However, there`s still no input from the keyboard. Even after the
> connection was estabilished properly, Wireshark is silent when I press
> keys on the keyboard.
>

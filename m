Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Bluetooth: Fix bt_sock_recvmsg when MSG_TRUNC is not set
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZJ1X-RHfy2MXnO-oHTKZF6UzM46-qcPxBB-nfFAeK8eHQ@mail.gmail.com>
Date: Mon, 15 Aug 2016 14:49:45 +0200
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <5F841655-86EA-42AE-B5AC-2A3D414B39DA@holtmann.org>
References: <1471003888-27124-1-git-send-email-luiz.dentz@gmail.com> <87popexe29.fsf@intel.com> <E81E027B-A385-4A4F-B0EB-F7ACC3448352@holtmann.org> <CABBYNZJ1X-RHfy2MXnO-oHTKZF6UzM46-qcPxBB-nfFAeK8eHQ@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>>>> Commit b5f34f9420b50c9b5876b9a2b68e96be6d629054 attempt to introduce
>>>> proper handling for MSG_TRUNC but recv and variants should still work
>>>> as read if no flag is passed, but because the code may set MSG_TRUNC to
>>>> msg->msg_flags that shall not be used as it may cause it to be behave as
>>>> if MSG_TRUNC is always, so instead of using it this changes the code to
>>>> use the flags parameter which shall contain the original flags.
>>>> 
>>> 
>>> Taking a look at udp_recvmsg(), looks like this fix is indeed
>>> necessary. And that patch that "fixed" sdpd-server.c may not be needed
>>> at all.
>> 
>> and what about hci_sock_recvmsg function? Does it need the same fix?
> 
> Looks like it has the same problem, shall I send a patch or you will
> take care of it?

please send a patch for that one as well.

>> Also we should really create test cases for HCI and L2CAP/RFCOMM sockets when it comes to recv and send. I would propose to introduce a sock-tester application. Or feed it into l2cap-tester etc.
> 
> Indeed it would be great to have this covered, perhaps even covering
> the testing spec when possible so we can detect regressions to
> L2CAP/RFCOMM without having to run PTS.

Can you work on that to at least cover the basic socket cases with msg_flags. I mean most important are really HCI sockets and L2CAP sockets. Since they are used most.

Regards

Marcel


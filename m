Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v2 0/8] Avoid L2CAP ERTM shutdown hung tasks
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <559E45C2.70406@mentor.com>
Date: Thu, 9 Jul 2015 12:06:57 +0200
Cc: linux-bluetooth@vger.kernel.org, Joshua_Frkuska@mentor.com
Message-Id: <9DD0F167-008E-4819-8DE2-9739CEB4AB53@holtmann.org>
References: <1435078779-4436-1-git-send-email-Dean_Jenkins@mentor.com> <8070DCD7-709D-4B34-BD44-12D68DD71E21@holtmann.org> <20150709093626.GA19545@t440s.ger.corp.intel.com> <559E45C2.70406@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

please refrain from top-posting on this mailing list.

> Please can you point to me to some details on how to use the l2cap-tester tool so that I can attempt to look into this issue.

And the easiest way to run this for testing is this way:

	./tools/test-runner --kernel bzImage -- ./tools/l2cap-tester

If you have qemu installed. If available it should use KVM, but that would mean some sort of x86 based system ;)

In case you are on a target machine, just run ./tools/l2cap-tester.

Regards

Marcel


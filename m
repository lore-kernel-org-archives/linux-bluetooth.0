Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAo+LNMHzRLY0v_bZHYRqwSNiED74dmoovbisBOapuM=vB+WSg@mail.gmail.com>
References: <CAAo+LNOnDtHYjfLAQXj3Tgqiibd+oyKJP9109TfoGaDuAbmgag@mail.gmail.com>
	<CABBYNZLqxCSN6cViGY07e44C40i4Puvi7PqJtqhM6kDXWj_qaw@mail.gmail.com>
	<CAAo+LNPfXuE9+E2V3q5+m154GXTKuC6sbMVcuNWOB6K97vkytg@mail.gmail.com>
	<CAAo+LNMHzRLY0v_bZHYRqwSNiED74dmoovbisBOapuM=vB+WSg@mail.gmail.com>
Date: Mon, 7 Mar 2016 17:07:00 +0200
Message-ID: <CABBYNZKGwKEztXu1nV9cPNSNek66cAuMju=+Eaksu6YgFLt3gA@mail.gmail.com>
Subject: Re: BTLE pairing sequence problem
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrew - <hidefromkgb@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrew,

On Mon, Mar 7, 2016 at 4:27 PM, Andrew - <hidefromkgb@gmail.com> wrote:
>> I don't remember having any problems pairing the Designer Keyboard, how did you actually connected to it?
> $ bluetoothctl
> [NEW] Controller 00:08:CA:E7:CD:35 UX31E [default]
> [NEW] Device E8:12:16:14:E0:20 Designer Mouse
> [NEW] Device C1:C3:5B:2E:97:B9 Designer Keyboard
> [bluetooth]# agent DisplayYesNo
> Agent registered
> [bluetooth]# default-agent
> Default agent request successful
> [bluetooth]# pair C1:C3:5B:2E:97:B9
> Attempting to pair with C1:C3:5B:2E:97:B9
> [CHG] Device C1:C3:5B:2E:97:B9 Connected: yes
> [Designer Keyboard]# connect C1:C3:5B:2E:97:B9
> Attempting to connect to C1:C3:5B:2E:97:B9
> Connection successful
> [bluetooth]#
>
> And that`s pretty much the end. The «Ready to connect» LED still
> flashes and no input can be retrieved from the keyboard.
>
> dmesg shows its usual line:
> [180261.398350] Bluetooth: SMP security requested but not available

I think your problem start way before then, checking the logs this is
where that check got introduced:

Bluetooth: Fix NULL pointer dereference in smp_conn_security
The l2cap_conn->smp pointer may be NULL for various valid reasons where SMP has
failed to initialize properly. One such scenario is when crypto support is
missing, another when the adapter has been powered on through a legacy method.
The smp_conn_security() function should have the appropriate check for this
situation to avoid NULL pointer dereferences.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Cc: stable@vger.kernel.org # 4.0+

Perhaps you are missing the crypto support?

-- 
Luiz Augusto von Dentz

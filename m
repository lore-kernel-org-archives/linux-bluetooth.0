Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAo+LNPfXuE9+E2V3q5+m154GXTKuC6sbMVcuNWOB6K97vkytg@mail.gmail.com>
References: <CAAo+LNOnDtHYjfLAQXj3Tgqiibd+oyKJP9109TfoGaDuAbmgag@mail.gmail.com>
	<CABBYNZLqxCSN6cViGY07e44C40i4Puvi7PqJtqhM6kDXWj_qaw@mail.gmail.com>
	<CAAo+LNPfXuE9+E2V3q5+m154GXTKuC6sbMVcuNWOB6K97vkytg@mail.gmail.com>
Date: Mon, 7 Mar 2016 17:27:50 +0300
Message-ID: <CAAo+LNMHzRLY0v_bZHYRqwSNiED74dmoovbisBOapuM=vB+WSg@mail.gmail.com>
Subject: Re: BTLE pairing sequence problem
From: Andrew - <hidefromkgb@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> I don't remember having any problems pairing the Designer Keyboard, how did you actually connected to it?
$ bluetoothctl
[NEW] Controller 00:08:CA:E7:CD:35 UX31E [default]
[NEW] Device E8:12:16:14:E0:20 Designer Mouse
[NEW] Device C1:C3:5B:2E:97:B9 Designer Keyboard
[bluetooth]# agent DisplayYesNo
Agent registered
[bluetooth]# default-agent
Default agent request successful
[bluetooth]# pair C1:C3:5B:2E:97:B9
Attempting to pair with C1:C3:5B:2E:97:B9
[CHG] Device C1:C3:5B:2E:97:B9 Connected: yes
[Designer Keyboard]# connect C1:C3:5B:2E:97:B9
Attempting to connect to C1:C3:5B:2E:97:B9
Connection successful
[bluetooth]#

And that`s pretty much the end. The «Ready to connect» LED still
flashes and no input can be retrieved from the keyboard.

dmesg shows its usual line:
[180261.398350] Bluetooth: SMP security requested but not available

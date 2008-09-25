Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Sep 2008 13:50:48 -0700 (PDT)
From: Chris Rankin <rankincj@yahoo.com>
Reply-To: rankincj@yahoo.com
Subject: Re: Cannot pair A2DP speakers with Belkin Bluetooth adapter
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-ID: <521317.58816.qm@web52911.mail.re2.yahoo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> For those two low-level test commands the behavior you describe is  
> perfectly normal and expected. However, they certainly aren't a proper  
> way to initiate pairing. Where did you get the idea that this is the  
> right way to do pairing? If it was in some BlueZ documentation we  
> should fix it ASAP. You might want to check the bluez wiki for some  
> ways to perform pairing (hint: search for "CreateBonding"):
> http://wiki.bluez.org/wiki/HOWTO/Bonding

Johan,

Sorry for the long delay in responding; I've only just found your reply.

As to my approach to pairing, I was driven to such extremes by a lack of working alternatives :-). Pairing the speakers with the laptop was easy - I was prompted for a PIN code, entered it, and all was well. However, when I tried to do the same for the desktop, the PIN-entry dialog box would always vanish before I could type more than the first digit! As a result, I resorted to lower- and lower-level techniques to find out what on Earth was going wrong.

I actually cracked the problem *only this morning*, having discovered hcidump last night! (This is a problem that's been on the back-burner for a while...) What appears to have been happening is that the speakers only allow devices to bond with them for a few minutes after the speakers are switched on. (This isn't made at all clear in the manual.) If you try to pair after that then the speakers ignore you and just drop the connection. More significantly, they don't even keep the connection alive long enough to respond to (i.e. reject) an outstanding attempt to send a PIN. What I eventually did was the following:

* Run hcidump -V in one window
* Run l2ping <bdaddr> in another window to open a connection and *keep* it open.
* Run hciconfig auth <bdaddr> in a third window.

And no, this didn't work either. But it did at least allow the speakers *refusal* to bond to appear in the dump output :-). Once it became clear that a) the speakers did possess a "pairing mode", and b) that the speakers weren't *in* "pairing mode" then bonding them to the adapter became easy.

As to the Linux Bluetooth documentation, it appears that BT support has evolved rapidly and significantly over the past year or two, and Google has a looong memory. Much of the advice I was digging up seemed out-of-date. Also, it all expected bonding to Just Work, and none of the errors I was seeing gave any indication of what the underlying problem actually was. For example, I think ALSA's error from aplay was about a GET CAPABILITIES call failing. Similarly, a Connect() call from Python just gave an I/O error.

Anyway - it all works NOW :-).

Thanks,
Chris



      

Return-Path: <cyrus@holtmann.org>
Message-Id: <7.0.1.0.2.20090908144122.02210dd8@gmx.net>
Date: Tue, 08 Sep 2009 15:01:28 +0200
To: linux-bluetooth@vger.kernel.org
From: Peter Kornatowski <pkorn@gmx.net>
Subject: AnswerRequested-signal just works with HSP, but not with HFP?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I want to make use of the answer-button of a bt-headset in my linux 
app but it just works in HSP, not in HFP mode (I have been playing 
around with this since bluez 4.3x, but the error stayed).
I tried this in C and in python and I get the AnswerRequested-signal 
only when "HFP=false" is set in /etc/bluetooth/audio.conf.
Tests with three different headsets and on two different computers 
(Ubuntu laptop and debian lenny desktop PC) showed the exact same behaviour.
HSP would be enough for me, but when HFP is true, the range of the 
headsets increases from like 5 to 20 meters until the sound gets 
choppy (although the headsets are class2, but the adapter is class1), 
and I would like to make use of the extended range.
Is this normal or do I have misconfigured something (for both the 
range and the answer-signal)?

Thanks, Peter

P.S.: I still have the error from last week with getting speakergain 
of the headsets in C, any help is appreciated.


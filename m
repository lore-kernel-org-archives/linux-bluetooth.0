Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Sudha S <sudhas.raghavan@gmail.com>
Date: Mon, 22 May 2017 13:05:34 +0530
Message-ID: <CAK8T_aUcSDWmhW18W6CrQFXe+_OKA3XyXZBrwPCpgbV4b+W6xw@mail.gmail.com>
Subject: Question on switiching codecs with bluez 5
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello ,

  I have a device that is registered as a A2DP source.
In my code , I am registering with 2 codecs as endpoints SBC and AAC .
I am using the bluez 5 calls for this .

I am connecting this to a SONY speaker that supports AAC and SBC.

The SetConfiguration and SelectConfiguration callbacks received are
for the "AAC endpoint" .
AAC content gets played .
My device (source) supports other audio formats other than AAC .

Question 1 :
------------------
Can the non AAC content be played now  by the speaker ? Or is it
expected that the input tot he speaker should now always be AAC.

Question 2:
----------------
If yes, then how can this be done with bluez?

Question 3:
------------------
In my code with 2 RegisterEndpoint calls, if the code registers for
SBC first followed by AAC, then the Select/Set callbacks are received
for SBC .
If the order of calls is switched i.e Register endpoint with AAC as
codec first followed by SBC, then the callbacks are reeceived for AAC
.

Is this the expected behavior or is this device (sink) specific ?

Thanks ,
Sudha.S

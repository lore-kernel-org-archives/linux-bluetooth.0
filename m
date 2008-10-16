Return-Path: <cyrus@holtmann.org>
From: Ralph Gillen <Ralph.Gillen@web.de>
To: linux-bluetooth@vger.kernel.org
Subject: Pairing and HCI filters
Date: Thu, 16 Oct 2008 09:55:54 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200810160955.54846.Ralph.Gillen@web.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I'm running a 2.6.18 kernel on Scientific Linux 5.2 with bluez 3.7 installed, 
and I'm trying to build a software for a experimental setup in which several 
bluetooth devices are involved. I just need a RFCOMM connection to each of 
these devices, and as long as I don't need pairing everything works fine. I 
read many lines of code to understand how the pairing process works (the same 
way I learned how to communicate with my devices at all), an here ist what I 
figured out until now: after a connection request, my device asks for the 
PIN; this ist noticed by bluez, and via this d-bus interface an agent is 
called to anser the request (is this - roughly- correct?). After installing 
kdebluetooth-1.0_beta8, the pairing process works for me if I enter a fixed 
PIN in the setup file.

But what I need is to answer the pairing request directly from my program 
(because there are many different devices and PINs and it should work without 
user interaction). It seems to me that I have to set a filter on the HCI (but 
how exactly?) and wait for the incoming request (again: how?) and finally 
answer it, i.e. I want to catch the request before the whole d-bus/agent 
stuff becomes involved.

So I'd like to ask the following questions:

- is this the right mailing list? ;) (I found no other)

- is there any documentation on HCI programming including event filtering I've 
not found yet?

- is my understanding of the process correct?

- can anyone point me out a program that does what I need, so that I could 
learn from the source code?

- does anybody have pieces of code answering a pairing request on HCI level 
(so, not agents!)?

- or any other hints?

This is a research project, and I'm not at all familiar with bluetooth (which 
should count for not more than 1% of the project), so please excuse if my 
questions are not very exact. Any help is appreciated, thank you very much!

Best regards,

Ralph


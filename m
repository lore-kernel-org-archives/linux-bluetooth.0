Return-Path: <cyrus@holtmann.org>
Message-ID: <4E45B5F1.4020807@Dartmouth.edu>
Date: Fri, 12 Aug 2011 19:23:29 -0400
From: Isaiah Sarju <Isaiah.Sarju@Dartmouth.edu>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: RFCOMM channel 1 behavior differences
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

Does Ubuntu, linux kernel 2.6.38.10, running bluez 4.91-0ubuntu1 have a 
special security policy for incoming rfcomm connections on channel 1, 
and not other channels?

I ask this because I can create rfcomm connections between two computers 
on other channels (2, 3, 11, 13, etc.) but the listening computer 
refuses connections when connection requests come in for channel 1.

I use the following commands:

on listening computer:
	sudo rfcomm listen hci0 <channel>

on connecting computer:
	sudo rfcomm connect hci0 <BD_ADDR> <channel>

When <channel> does not equal 1 both computers connect no with no 
problem. When <channel> equals 1 I receive the error "Can't connect 
RFCOMM socket: Connection refused"

I tried this in to two different environments. 1) in a X-session and 2) 
in command line

1) in GUI on the listing computer a dialogue box pops up requesting a 
pin for pairing. When I click cancel on the dialogue box of the 
listening machine the error "Can't connect RFCOMM socket: Connection 
refused" appears on the command line of the connecting machine.

2) in command line mode on the listening computer nothing appears and I 
immediately receive the error "Can't connect RFCOMM socket: Connection 
refused" on in the command line of the connecting machine

These problems do not arise when attempting to connect on any other 
channels.

I have searched Google, looked at multiple forum posts on rfcomm 
connections, looked at forum posts on peoples' problems with rfcomm 
connections, reviewed this mailing list's archives, and I cannot find my 
specific problem.

Thank you for any advice you can provide or resources to which you can 
point me.

Regards,
Isaiah

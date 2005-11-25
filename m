Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Agustin Fusaro <afusaro@apexar.com>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1132928387.3260.11.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-users] Multiple RFCOMM disconnection problem
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 25 Nov 2005 11:19:46 -0300

Hi everybody, here's my problem:

When I try to connect more than 2 RFCOMM connections (on different
ports), everything works fine until I disconnect the last connection:

In other words, I can create multiple RFCOMM connections on different
ports, but when I try and disconnect, the computer freezes (on fedora 4
kernel 2.6.11) or just displays a segfault and I can't kill the process
(o Knoppix kernel 2.6.14).

I tried with different USB dongles, updated to the last release of Bluez
(rfcomm version 2.22) and nothing changes...

This is a very strange problem... and only ocurrs when I try to connect
to more then 2 BT devices.

Here's what I do:
I have two computers, each one with one dongle. On the listener side I
run on different terminals:

>rfcomm listen 1 1
>rfcomm listen 2 2
>rfcomm listen 3 3
and so on...

on the client side I run

>rfcomm connect 1 <bdaddress> 1
>rfcomm connect 2 <bdaddress> 2
>rfcomm connect 3 <bdaddress> 3

everything works fine until I disconnect (CTRL+C from the client side)
the 3rd connection. I tried with more than 3 connections and the system
freezes when I disconnect the last connection.

I'd really appreciate any feedback on this problem... I am at a lost
here... Has this ever happened to you?

Thanks very much for your time!

Agustin Fusaro



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Marcus Better <marcus@better.se>
Message-ID: <loom.20041221T214657-660@post.gmane.org>
References: <41C80A43.4030105@better.se> <41C864A3.6010300@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Re: snd-bt-sco and Motorola HS801 success
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 21 Dec 2004 20:50:59 +0000 (UTC)

Brad Midgley <bmidgley <at> xmission.com> writes: 
> IIRC, btsco (the daemon) prints out what AT commands are being send and  
> received during volume changes. What does it print when you try to use  
> alsamixer? 
 
Here's the output, with some comments: 
 
# btsco 00:0b:2e:21:9e:1c 
Device is 2:0 
Voice setting: 0x0060 
RFCOMM channel 1 connected 
speaker volume: 7 mic volume: 1 
recieved AT+CCWA=1 
recieved AT+VGS=9 
Sending up speaker change 9 
    <here the headset button is pressed> 
recieved AT+CKPD=200 
opened hwdep 
    <few seconds delay here> 
connected SCO channel 
Setting sco fd 
Done setting sco fd 
    <pressed "volume up" on headset> 
recieved AT+VGS=10 
Sending up speaker change 10 
    <pressed "volume down" on headset> 
recieved AT+VGS=9 
Sending up speaker change 9 
    <pressed "volume down" on headset> 
recieved AT+VGS=8 
Sending up speaker change 8 
    <changing volumes using alsamixer> 
speaker volume: 9 mic volume: 1 
speaker volume: 8 mic volume: 1 
speaker volume: 8 mic volume: 5 
speaker volume: 8 mic volume: 6 
speaker volume: 8 mic volume: 5 
speaker volume: 8 mic volume: 6 
speaker volume: 6 mic volume: 6 
    <pressed "volume up" on headset> 
    <apparently the alsamixer setting is now forgotten> 
recieved AT+VGS=9 
Sending up speaker change 9 
    <pressed headset button again to hang up> 
recieved AT+CKPD=200 
disconnected SCO channel 
 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

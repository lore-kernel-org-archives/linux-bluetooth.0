Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44986D90.2090505@fh-wolfenbuettel.de>
Date: Tue, 20 Jun 2006 23:50:08 +0200
From: Goetz Issel <g.issel@fh-wolfenbuettel.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <mailman.1467.1150830573.9417.bluez-devel@lists.sourceforge.net>
In-Reply-To: <mailman.1467.1150830573.9417.bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] blueZ and SAP
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Mayank,

>
>First of all, please do not reply on individual ids.


sorry for PM, will post here in list again.

 I do get a message back from the mobile phone, of course after first 
sending a message to it..
The response of a 'connect-req' from the phone is:
header:            1100, the response message header is correct, since 
it has the correct MsgID that corresponds to 'connect-resp'

parameter #1:  10010000 ,  meaning that it is the parameterID 
'ConnectionStatus', with parameter value length 1 and the value is 0 (= 
OK, server can fulfill the requirements)

This message is received  from a Nokia 6810 and the MaxMsgSize requested 
in the 'connection-req' was 0x0118. It looks promising so far. I will 
try to get a few more things done now.
When I request an initial MaxMsgSize of 0xff ff the mobile phone 
responds with
header: 1200 , so now 2 parameters in the 'connect-resp' message coming up
parameter #1: 10012000 , connectionStatus  now gives 'Error, Server does 
not support maximum message size'
parameter #2: 00028000 , the server now suggests MaxMsgSize to be 0x800

And... when I request a small MaxMsgSize (ie 0x0001) the SIM server 
returns the expected 'Error, maximum message size by Client is too small' 

In case you decide to work on this subject as well I am interested in a 
bit of team work.

> > first of all I am happy to hear that there is somebody out there working
> > on this too. I thought I was on my own since I never got any helpful
> > response on the list so far.
> >
> > I have been checking the returned values in 2 ways.
> >
> > First I tried to use "read()" on the socket on which I did the "write()"
> > before. I got no response at all. By the way, I am using  Nokia 6810 and
> > a Siemens S65 for testing.
>   
>Hang on, if you do a read() before write(), won't the read block your
>thread? and your control will never reach the write()?
>Or are you using different threads for the read and write?

> > problem. I need to implement the whole sap profile. Panic!
> >
> > If you have any decend code I can use... please help. If you want I can
> > send you the code I have so far.
>   
>No, I did not have any code actually, I just made the RFCOMM connection, and
>I was sending the connect_req etc on this rfcomm device (/dev/rfcomm0). So I
>wrote the connect_req in hex form in a file and then simply did cat file >
>/dev/rfcomm0

>Regards,
>Mayank

Greetings,
Goetz



_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4562CDCE.3060603@idlum.be>
Date: Tue, 21 Nov 2006 10:58:38 +0100
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4561DDBE.6040508@idlum.be> <1164042206.28397.36.camel@localhost>
In-Reply-To: <1164042206.28397.36.camel@localhost>
Subject: Re: [Bluez-devel] Extracting full SDP database from device at	once
 using DBus API
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

Hi Marcel,

Thanks a lot for your kind answer.

Pierre-Yves



Marcel Holtmann wrote:
> Hi Pierre-Yves,
> 
>> At the moment, to perform a full extraction of the SDP database of a 
>> device, I first perform a call to
>>
>> array{uint32} GetRemoteServiceHandles(string address, string match)
>>
>> with an empty "match" string. It does connect to Public Browse Group, 
>> and returns handles for all the ServiceRecords. I then perform a call
>>
>> array{byte} GetRemoteServiceRecord(string address, uint32 handle)
>>
>> for each of these handles, and I get all the data in binary form ti 
>> interpret myself.
>>
>>
>> 1) Is it the right way to do this, or is there a way to get that all at 
>> once?
> 
> that is the way to go.
> 
>> 2) As ServiceRecords are extracted "one at a time", is Bluez connecting 
>> and disconnecting to the device each time? Is there a performance 
>> penalty in doing so? If I understand the output of hcidump well, it does 
>> not close he ACL link each time, but there is a L2CAP 
>> connection/disconnection for each ServiceRecord.
> 
> We should add a disconnect timeout to our SDP session and re-use it, but
> that hasn't been done so far.
> 
> Regards
> 
> Marcel
> 
> 
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

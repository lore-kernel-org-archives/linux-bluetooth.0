Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41F29274.3020909@webstuhl.net>
From: Ben Pezzei <ben@webstuhl.net>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: Again: Problems with Dongle, Headset or btsco
References: <41F0EB0A.1020302@webstuhl.net> <41F0FE84.8030401@dark-reality.de> <41F128F4.2020006@webstuhl.net> <41F13638.1080207@dark-reality.de> <41F25C4B.6040709@webstuhl.net> <csts46$p5n$1@sea.gmane.org>
In-Reply-To: <csts46$p5n$1@sea.gmane.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Sat, 22 Jan 2005 18:50:44 +0100

Hi Sebastian,

Sebastian Roth schrieb:

>> unfortunately
>> arecord -D plughw:Headset z1.out
>> Recording WAVE 'z1.out' : Unsigned 8 bit, Rate 8000 Hz, Mono
>>
>> only creates a 44 Byte big file z1.out with the header but
>> no content
> 
> For older versions of arecord this is the usual behaviour. Update 
> alsa-tools or try the commandline switch '-d' (man arecord).

Well, I'll give it a last try: I'll patch the kernel
with the mh1 patch from bluez and the latest alsa libs.
(currently installed arecord version is 1.0.7 - latest is 1.0.8),
although i doubt this will finally work :)

One very last Question (BT specific):

I upgraded the Dongle on a win xp box to BT 1.2. After reading
the docs, 1.2 has some changes in it regarding Audio which imho
affects the SCO part, right? Does it make sense to downgrade the
dongle to 1.1 (if possible)?

finally, tnx all for your replies & tips

greetings
ben



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

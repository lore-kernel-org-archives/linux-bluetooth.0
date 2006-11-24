Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45671438.5000604@palmsource.com>
Date: Fri, 24 Nov 2006 16:48:08 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <45640925.4040207@xmission.com> <45649452.6050904@xmission.com>
In-Reply-To: <45649452.6050904@xmission.com>
Subject: Re: [Bluez-devel] bluetooth-alsa website cleanup
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Brad,

If the current cvs is stable enough, I think it is a good idea to =

release it.
However, I have a patch on the grill so I would like you to be careful =

if you move the source now so that I could repost my patch easily. It =

should be ready by the end of next week.
I still have a few problems to solve and I will start looking at the =

DBUS api. The patch will contain unix sockets, less threads, new avrcp =

commands, sdp records, cleaner traces, plus a try to send sound using sco.

Regards,
Fr=E9d=E9ric.


Brad Midgley a =E9crit :
> Oh...
>
> I forgot to mention that this was the last checklist item for a snapshot
> release. I'll be calling it btsco-0.5. I will be moving the alsa plugins
> to a different source control module after this and won't be making any
> new btsco releases.
>
> Please let me know if you see any issues that need to be addressed first.
>
> Brad
>
>   =

>> fyi, I merged our various sources of documentation and put everything =

>> together in a fairly spartan tabbed interface.
>>
>> http://bluetooth-alsa.sf.net/
>>
>> Brad
>>
>> -------------------------------------------------------------------------
>> Take Surveys. Earn Cash. Influence the Future of IT
>> Join SourceForge.net's Techsay panel and you'll get the chance to share =
your
>> opinions on IT & business topics through brief surveys - and earn cash
>> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=
=3DDEVDEV
>> _______________________________________________
>> Bluez-devel mailing list
>> Bluez-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>     =

>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share y=
our
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>   =



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

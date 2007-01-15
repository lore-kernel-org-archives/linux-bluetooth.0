Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45ABAF4B.6050702@palmsource.com>
Date: Mon, 15 Jan 2007 17:43:55 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <200701150305.07478.bluez-devel@huitl.de>
	<45AB9C88.1040808@xmission.com>
In-Reply-To: <45AB9C88.1040808@xmission.com>
Subject: Re: [Bluez-devel] a2dpd: cmdplay fails: "No such application:
 'amarok player play'"
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

I already tried system here and this led to strange interactions between =

processes. I just tried it again (in case it would be better) and it is =

still the same.

Here is the procedure to reproduce :
 - xmms must not be started.
 - start a2dpd.
 - then from an avrcp headset press play to connect : xmms will start.
 - kill a2dpd : xmms will deadlock.

Any player should behave the same. I found that the a2dpd main unix =

socket must be closed immediatly after any fork(). I suspect the socket =

remain open in the xmms process space which will try to write to an open =

socket that is no longer polled for data, thus deadlock (btw, can any =

linux guru confirm?). Any process started by system() will be forked but =

this socket won't be closed.

More over, the execution must be asynchronous, system("xmms") will wait =

until you terminate xmms before returning, system("xmms &") should work.

It is still possible to fork() then close_server_socket() then system() =

as did Robert, but a shell is spawned for that (+ 2 additionnal fork =

calls!) which is a few megabytes that could be used better...

It should be enough to rewrite the parser code just before so it handles =

more parameters.
        char* argv[2];
        strncpy(command, cmd, sizeof(command));
        command[sizeof(command)-1]=3D '\0';
        argv[0] =3D strchr(command, ' ');
        if(argv[0]) { *argv[0]=3D'\0'; argv[0]++; }

I stay open to any other solutions if this limitation is a real problem, =

but as stated in amarok man page :
   Options:
       -r, --previous
              Skip backwards in playlist
       -p, --play
              Start playing current playlist
       -s, --stop
              Stop playback
       --pause
              Pause playback
       -f, --next
              Skip forwards in playlist

Fr=E9d=E9ric


Brad Midgley a =E9crit :
> Robert
>
> this idea looks ok. The extra fork() could be removed.
>
> Brad
>
>   =

>> Index: a2dpd_ipc.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> RCS file: /cvsroot/bluetooth-alsa/plugz/alsa-plugins/a2dpd/a2dpd_ipc.c,v
>> retrieving revision 1.3
>> diff -u -r1.3 a2dpd_ipc.c
>> --- a2dpd_ipc.c 12 Jan 2007 16:34:01 -0000      1.3
>> +++ a2dpd_ipc.c 15 Jan 2007 02:02:15 -0000
>> @@ -384,8 +384,10 @@
>>                                  close_server_socket_on_fork();
>>
>>                                  // Replace children with new process
>> -                                i =3D execlp(command, command, argv[0],=
 NULL);
>> -                                DBG("execlp failed %s=3D%d (errno=3D%d:=
%s)", cmd, =

>> i, errno, strerror(errno));
>> +                                system(cmd);
>> +                                exit(0);
>>                                  break;
>>                          case -1:
>>                                  // failed
>>     =

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



-- =

Frederic

Without the wind, the grass does not move.


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

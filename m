Return-Path: <cyrus@holtmann.org>
Message-ID: <4790B322.4040605@omepet.es>
Date: Fri, 18 Jan 2008 15:09:38 +0100
From: jm <jmtoro@omepet.es>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4790817D.3030400@omepet.es>
In-Reply-To: <4790817D.3030400@omepet.es>
Subject: Re: [Bluez-users] Problem when cancelling connect
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I forgot to mention I cancel the call to connect() using siglongjmp:

sigjmp_buf jmpbuf;

int sig_handler(int signo)
{
    siglongjmp (jmpbuf, 1);
}

...

signal (SIGALRM, sig_handler);

alarm( MAX_CONNECT_TIME );

if (!sigsetjmp(jmpbuf, 1)){
    BtOBEX_TransportConnect(handle, BDADDR_ANY, &bdaddr, channel)
    alarm(0);  
    ...
}
else{
    signal (SIGALRM, SIG_DFL);
    return -1;
}
> Hi all!
>
> I'm trying to cancel a call to connect() (The one called by 
> BtOBEX_TransportConnect) using a SIGALRM signal. It works fine, but a 
> random subsequent call to hci_inquiry() or sdp_connect() causes a 
> segmentation fault. I've tried to restore the default signal handler and 
> closing the socket by hand, with no luck. Any idea about what is going on?
>
> Thanks in advance
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>   


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

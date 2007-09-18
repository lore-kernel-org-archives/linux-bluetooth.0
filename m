Return-Path: <fchevalier@silicom.fr>
Message-ID: <46EFBDC4.3040506@silicom.fr>
Date: Tue, 18 Sep 2007 14:00:04 +0200
From: Fabien Chevalier <fchevalier@silicom.fr>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@nokia.com>,
        Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Fix bogus avdtp error codes management
References: <46EEBC41.80401@silicom.fr> <20070918081557.GA13401@localhost>	<1190104027.5525.128.camel@aeonflux.holtmann.net>	<46EF9302.50403@silicom.fr> <20070918090912.GA15007@localhost>
In-Reply-To: <20070918090912.GA15007@localhost>
Content-Type: multipart/mixed;
 boundary="------------050809030206020408020005"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------050809030206020408020005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Johan Hedberg wrote:
> On Tue, Sep 18, 2007, Fabien Chevalier wrote:
>> As for the POLLOUT thing, i must say i'm confused..., and don't really 
>> see the link with the patch :-(
>> I guess it works already as the GIOChannels heavily rely on it.
> 
> GLib maps POLLOUT to G_IO_OUT, POLLHUP to G_IO_HUP, etc. I was saying
> that to conform to how other socket types behave[1] the callback should
> *not* be getting a HUP or ERR in this case but a OUT instead. As for
> applying the patch, I'm fine with it even though it in essence is a
> work-around for a kernel side problem. However, it's Marcel's call in
> the end.
> 
> [1] I have yet to verify this but that's what the connect(2) manpage
> implies (in the section about EINPROGRESS)

Ok, thanks, this time i understood. :-)
I wrote a test program that does an asynchronous connect using the IP 
stack. (I attached the file, you can dry run yourself if you're curious 
;-) ). On error we receive a revent with POLLERR value, and no POLLOUT.
Conclusion is:
   * POLLOUT is to be sent only when the channel is ready to send more data.
   * POLLERR is the right thing to send when we cannot establish the 
connection due to whatever error ==> The man page is a bit ambiguous 
about it.
   * which means the bt kernel part is fine and does not need fixing
   * which means my patch is not a workaround but a clean fix to this 
bogus error returning code :-)

Marcel, Johan, if you don't have any other remarks, you would mind 
applying the patch ?

Cheers,

Fabien

--------------050809030206020408020005
Content-Type: text/x-csrc;
 name="main.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="main.c"

#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <poll.h>
#include <errno.h>
#include <assert.h>
#include <fcntl.h>

int main()
{
    struct sockaddr_in addr;
    int err;
    struct pollfd pfds;

    int sock = socket(AF_INET, SOCK_STREAM, 0); 

    addr.sin_family = AF_INET;
    addr.sin_port = htons(81);
    addr.sin_addr.s_addr = inet_addr("209.85.135.104");

    fcntl(sock, F_SETFL, fcntl(sock, F_GETFL, 0) | O_NONBLOCK);

    err = connect(sock, (struct sockaddr *)&addr, sizeof(addr));
    
    assert(err == -1 && errno == EINPROGRESS);
    
    pfds.fd = sock;
    pfds.events = POLLOUT;
    
    err = poll(&pfds, 1, -1);
    assert(err == 1);
    
    printf("returned events from poll() routine:");
    if(pfds.revents & POLLOUT)
        printf("POLLOUT");
    if(pfds.revents & POLLERR)
        printf("POLLERR");

    printf("\n");    
}

--------------050809030206020408020005
Content-Type: text/x-vcard; charset=utf-8;
 name="fchevalier.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fchevalier.vcf"

begin:vcard
fn:Fabien CHEVALIER
n:CHEVALIER;Fabien
org:SILICOM
adr:;;4 rue de Jouanet; RENNES ATALANTE;;35700;FRANCE
email;internet:fchevalier@silicom.fr
title:Software & Studies Engineer
tel;work:+33 (0) 2 99 84 17 17
version:2.1
end:vcard


--------------050809030206020408020005--

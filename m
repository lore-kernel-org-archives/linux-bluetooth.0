Return-Path: <steve.crane@rococosoft.com>
Subject: Re: [Bluez-users] How do I obtain a free PSM automatically?
From: Stephen Crane <steve.crane@rococosoft.com>
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Cc: Alexandros Karypidis <karypid@inf.uth.gr>, BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1044653120.32671.4.camel@pegasus.local>
References: <200302071951.35073.karypid@inf.uth.gr>
	<1044653120.32671.4.camel@pegasus.local>
Content-Type: text/plain
Message-Id: <1044704544.2164.1436.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Date: 08 Feb 2003 11:42:24 +0000
List-ID: <bluez-users.lists.sourceforge.net>

On Fri, 2003-02-07 at 21:25, Marcel Holtmann wrote:
> Hi Alexandros,
> 
> > I was assuming that the setting the psm field to zero would get you a 
> > dynamically assigned free PSM on the local host:
> > 
> >   addr.l2_family = AF_BLUETOOTH;
> >   bacpy(&addr.l2_bdaddr, BDADDR_ANY);  
> >   addr.l2_psm = htobs(0);
> > 
> > Calling bind() for this address succeeds.
> > Calling listen() afterwards fails and perror() gives: "Invalid argument"
> 
> you can't listen on PSM 0, because such PSM did not exists. You have to
> choose one.

It would be nice if it had the expected semantics (i.e., those of IP sockets).
I think this is a bug.

In the meantime, here is some code:

   for (;;) {
      while (psm++ < 0xffff)
         if ((psm & 0x0001) && !(psm & 0x0100))
            break;
      if (psm == 0x10000) {
         // no resources
         close(s);
         return -EBUSY;
      }
      addr.l2_psm = htobs(psm);
      if (0 == bind(s, (struct sockaddr *)&addr, sizeof(addr)))
         break;
      if (errno != EADDRINUSE) {
         int e = -errno;
         close(s);
	 return e;
      }
   }

Enjoy,
Steve
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)

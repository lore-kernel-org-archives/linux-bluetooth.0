Return-Path: <ABHISHEK.BHATT@motorola.com>
Message-ID: <5987A7CB1694D811A04D0002B32C289601BF3C04@il93exb05.corp.mot.com>
From: Bhatt Abhi-ABHATT <ABHISHEK.BHATT@motorola.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Service level security for RFCOMM
Date: Fri, 29 Oct 2004 15:04:03 -0500
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

> And btw I got the service level security for incoming RFCOMM channels
> working on my development system and I did it without modifying the
> current state machine and it is hopefully SMP safe. I think we need
> another timer on the server side that kills the connection if nobody
> wants to authenticate, but thats another thing to look at. So someone
> owes me a crate full of beer :)
That is great news!! When do i get to see the code:) I don't know 
where you live or else you would have a crate full of beer delivered to you
right about now:) Thanks a bunch.	

Regards
Abhi

Hi Abhi,

don't forget to use the "Reply to All" button ;)

> > it is the same. I already committed the needed stuff to the CVS and
> > changed rctest to set them. However without a correct kernel the call of
> > setsockopt() will fail.
> I am not clear on what this means. Could you please explain what it is that
> you've added and committed in to CVS ?

I like to say look at my latest changes in the CVS and look at rctest,
but it seems that the anonymous CVS is not in sync with the developer
CVS. Again, this is a Sourceforge problem and I heard of other projects
that had the same problems at the moment.

However, I added RFCOMM_LM and RFCOMM_LM_AUTH resp. RFCOMM_LM_ENCRYPT
with the same values as we used for their L2CAP_* counterparts. So you
can use the setsockopt() with these values to achieve the same effect as
you expect on L2CAP. But without a kernel that knows about RFCOMM_LM the
setsockopt() and getsockopt() calls will fail.

And btw I got the service level security for incoming RFCOMM channels
working on my development system and I did it without modifying the
current state machine and it is hopefully SMP safe. I think we need
another timer on the server side that kills the connection if nobody
wants to authenticate, but thats another thing to look at. So someone
owes me a crate full of beer :)

Regards

Marcel

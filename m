Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20041017154240.40997.qmail@web41106.mail.yahoo.com>
From: Sean Loh <blaze_wk@yahoo.com>
Subject: Re: [Bluez-users] hcidump and l2cap questions
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1098026437.4911.91.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 17 Oct 2004 08:42:40 -0700 (PDT)

Hi again Marcel,

Thanks for the quick response!!!!

1. Does that mean that bluez constantly fragments all
upperlayer protocols to a max of 1500 bytes?

2. What does the parameters of these hcidump mean?
1098027478.336048 < BNEP: Compressed(0x02|0)
    [proto 0x0800]

As usual thanks a lot..!!!!


--- Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Sean,
> 
> > I'm streaming audio from one computer to another
> > computer  using the pan profile.
> > 
> > 1. I would like to see bnep packets being filtered
> > through hcidump. But when i put the bnep filter
> on,
> > hcidump does not print out anything. It only seems
> to
> > print out acl and l2cap data. Why is that? How am
> I
> > able to see bnep packet info?
> 
> simply call "hcidump -x" and be happy. However if
> you miss the initial
> l2cap_connect_req the dynamic channel assignment
> don't works.
> 
> > 2. I notice that even if i send udp packets that
> have
> > 55000 bytes. The maximum packet length that turns
> up
> > on hcidump is 1500 bytes. Shouldn't it be 55000
> bytes
> > because the max mtu for an l2cap packet is 65535
> > bytes?
> 
> The L2CAP uses segmentation and we use a MTU of
> 1691. Start thinking a
> little bit about the Ethernet frame size and so on.
> 
> Regards
> 
> Marcel
> 
> 
> 



		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

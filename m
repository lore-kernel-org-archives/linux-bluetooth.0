Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 31 Jul 2006 18:06:45 -0700
From: John Gruenenfelder <johng@as.arizona.edu>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20060801010645.GA5482@as.arizona.edu>
References: <20060801001207.GA5092@as.arizona.edu>
	<1154398819.4982.63.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
In-Reply-To: <1154398819.4982.63.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-users] Pairing problem with Plantronics headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Tue, Aug 01, 2006 at 04:20:19AM +0200, Marcel Holtmann wrote:
>Hi John,
>
>run "hcidump -X -V" and try again to see what is going on.
>
>Regards
>Marcel

Thanks for the quick reply.  I ran the above command and saw in the output
that the requested pin was being delivered as 0000.  But I also noticed that
the length was 5 bytes.

Looking closer, I see that the pin is actually 0000 plus 0x0A.  I had set the
pin by:
  echo "0000" > default

But that tacked on a linefeed.  Using "echo -n" instead solved the problem and
now the headset pairs and I get audio via btsco.  Thanks.


-- 
--John Gruenenfelder    Research Assistant, UMass Amherst student
                        Systems Manager, MKS Imaging Technology, LLC.
Try Weasel Reader for PalmOS  --  http://gutenpalm.sf.net
"This is the most fun I've had without being drenched in the blood
of my enemies!"
        --Sam of Sam & Max

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

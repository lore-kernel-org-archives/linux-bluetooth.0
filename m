Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: James Cameron <james.cameron@hp.com>
To: h0016530@hkusua.hku.hk
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Questions about Role Changing during PAN setup
Message-ID: <20040708051343.GF18689@hp.com>
References: <1089262620.40ecd41c49ef3@imp.webmail.hku.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1089262620.40ecd41c49ef3@imp.webmail.hku.hk>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 8 Jul 2004 15:13:43 +1000

On Thu, Jul 08, 2004 at 12:57:00PM +0800, h0016530@hkusua.hku.hk wrote:
> #sftp 10.0.0.2
> Connecting to 10.0.0.2...
> root@10.0.0.2's password:
> Request for subsystem 'sftp' failed on channel 0
> Connection closed

This is what happens if the connection is closed due to tcpd filtering.

Check /etc/hosts.allow has an entry for the IP address of the client.
For example, mine has "ALL: 10.0.0.0/255.255.255.0"

-- 
James Cameron
Software Security Response Team
HP Services, Asia Pacific


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

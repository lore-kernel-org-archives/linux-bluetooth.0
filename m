Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Catalin Drula <catalin.drula@imag.fr>
Message-ID: <loom.20050324T130536-748@post.gmane.org>
References: <Pine.LNX.4.33.0503171141200.22782-100000@redbean.intranet.gw-instruments.de>  <1111057586.11792.58.camel@pegasus>  <loom.20050324T123636-904@post.gmane.org> <1111664767.1916.54.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Re: Handling a Hardware Error event on iPAQ h5550
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
Date: Thu, 24 Mar 2005 12:17:23 +0000 (UTC)

Hi Marcel,

Marcel Holtmann <marcel <at> holtmann.org> writes:

> > > we can do this and actually calling "hcitool cc" does this already, but
> > > it waits indeed for a timeout of the HCI_Disconnect.
> > 
> > Could you give a few more details on this one, please? What I want to do is
> > what Pieter suggested: have the Hardware Error event trigger an unexpected
> > link loss on all active connections. 
> 
> if you wanna do this, then this should be done directly in the Bluetooth
> core module in the kernel. Look at hci_event.c and add the handling for
> the hardware error event to trigger the appropriate actions.
 
I know that it has to be done in hci_event.c; what I was trying to figure out
was what the necessary actions are. As far as I've been able to tell the
function hci_conn_hash_flush in hci_conn.c seems to do most of the work. Is that
it or is there something else to do? Should we tasklet_kill the RX and TX tasks?

A somewhat unrelated question, but I could not help noticing this: in
hci_conn.c, in function hci_conn_del there is this:

if (conn->type == SCO_LINK) {
                struct hci_conn *acl = conn->link;
                if (acl) {
                        acl->link = NULL;
                        hci_conn_put(acl);
                }
        } else {
                struct hci_conn *sco = conn->link;
                if (sco)
                        sco->link = NULL;

                /* Unacked frames */
                hdev->acl_cnt += conn->sent;
        }

I don't claim to have a good understanding of this code, but it seems that on
the true branch ACL is handled and on the false branch, SCO is handled. So
shouldn't that be:

if (conn->type != SCO_LINK)

Thanks for your help,

Catalin



-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

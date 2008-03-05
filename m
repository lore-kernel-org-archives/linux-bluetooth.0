Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300803050603k17a30359g173ab08f0756ff49@mail.gmail.com>
Date: Wed, 5 Mar 2008 07:03:45 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <2cb4fa160803050333j22a9bc9et68f30c2664d34061@mail.gmail.com>
MIME-Version: 1.0
References: <2cb4fa160803050333j22a9bc9et68f30c2664d34061@mail.gmail.com>
Subject: Re: [Bluez-users] Question about bluetooth simultaneous connections
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

Mohomed, you'll get closer to 7 if you try to keep your device master
on its connections. Something like calling a fn after estabishing
connections:

static void make_master(bdaddr_t bdaddr)
{
        uint8_t role = 0; // 0 means master
        int dd, dev_id;

        dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);
        if (dev_id < 0) {
                fprintf(stderr, "make_master: Not connected.\n");
                return;
        }

        dd = hci_open_dev(dev_id);
        if (dd < 0) {
                perror("HCI device open failed");
                return;
        }

        if (hci_switch_role(dd, &bdaddr, role, 10000) < 0) {
                perror("Switch role request failed");
        }
        close(dd);
}

-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

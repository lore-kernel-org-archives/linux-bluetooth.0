Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300802242256m699a9130se4257e4041f2b0b9@mail.gmail.com>
Date: Sun, 24 Feb 2008 23:56:29 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <d89ddf300802242243t9503c11ye3d5d2bc7ae1cebb@mail.gmail.com>
MIME-Version: 1.0
References: <47666E1F.2000902@mizi.com>
	<d89ddf300802242243t9503c11ye3d5d2bc7ae1cebb@mail.gmail.com>
Subject: Re: [Bluez-devel] forcing SCO connection patch
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Louis

I should clarify. It looks like the one Marcel saw was:

-	if (!conn)
-		goto unlock;
+	if (!conn) {
+		if (ev->link_type==SCO_LINK) {
+			conn = hci_conn_hash_lookup_ba(hdev, ESCO_LINK, &ev->bdaddr);
+			if (!conn)
+				goto unlock;
+			else
+				conn->type=SCO_LINK;
+			}
+	}

but yours was

-	if (!conn)
-		goto unlock;
+	if (!conn) {
+	    if (ev->link_type != ACL_LINK) {
+		int t = (ev->link_type == ESCO_LINK) ? SCO_LINK : ESCO_LINK;
+		conn = hci_conn_hash_lookup_ba(hdev, t, &ev->bdaddr);
+		if (conn)
+		    conn->type = ev->link_type;
+	    }
+	    if (!conn)
+	    	goto unlock;
+	}

they both have indent/space issues but I'm not sure Marcel's other
comment makes sense for what you did.

It seems like the problem is ev->link_type might have the wrong value
for the lookup to succeed, but I'm not sure what the big picture looks
like here. Is this the best place to solve it or was this a quick
workaround?

Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

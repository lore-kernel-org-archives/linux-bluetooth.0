Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <5.1.0.14.2.20021017114516.051d52d8@mail1.qualcomm.com>
To: bluez-users@lists.sourceforge.net, bluez-devel@lists.sourceforge.net
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: [Bluez-users] W2K PPP -> Linux PPP over RFCOMM
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 17 Oct 2002 11:45:44 -0700
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Folks,

I finally figured out how to get W2K with Widcomm BTW + PPP to work with dund. 
Originally we though that it might be RFCOMM flow control problem because W2K
side sends 6-7 packets and then shuts up. It turned out that it's just a   
coincidence. I verified flow control with HyperTerm --> rctest and everything
works beautifully.
The problem was in W2K PPP settings. There are several options that need to be disabled. 
Otherwise W2K PPP doesn't like Linux PPP responses. Typical scenario is PPPs exchange 5-6 
packets, then Linux rejects couple of requests and keeps sending new LCP and IPCP request 
but Windows side doesn't reply on them, at some point Linux gives up and kills connection. 

So, those who have problems with W2K PPP --> Linux PPP (I believe same applies to XP and ME).
Go to Network and Dialup settings and select BluetoothNullModem properties.
        - Disable encryption 
        - Enable only PAP and CHAP authentication 
        (not that you need any auth but at least one has to be enabled)
        - Disable 'ask for user name' option    (this one simply saves time)
        - Disable 'LCP extensions'      (this one seems to be the root cause of the problems)
        - Disable all protocols except TCP/IP (again saves negotiation time)

Those options are under whole bunch of different buttons like "Properties",  "Advanced", etc.
I don't remember where all of them are, so you'll have to do a bit of "clicking around" :)

That's it. Now connect is super fast (~1 sec) and totally reliable.
Connections stays up and handles load just fine. 

Enjoy.

Max

http://bluez.sf.net
http://vtun.sf.net



-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

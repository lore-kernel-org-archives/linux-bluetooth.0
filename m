Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Nokia 770 and SAP
Message-ID: <20051007180014.GA15869@localhost.localdomain>
References: <8047A06D0A6C6145A92DCE8E886AC2BF37F051@vwagwox00003.vw.vwg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8047A06D0A6C6145A92DCE8E886AC2BF37F051@vwagwox00003.vw.vwg>
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
Date: Fri, 7 Oct 2005 21:00:14 +0300

On Fri, Oct 07, 2005, Schnier, Carsten (EEFI/4) wrote:
> Is the SIM access profile (SAP) implementation used by Nokia part of BlueZ ?
> Is BlueZ with SAP free to download ? If yes, where ?

Unfortunately the SAP implementation is one of those components that
isn't open in maemo. If you want to play around with it on the 770
rootfs, try running /usr/bin/sap from the command line (hint: type
"help" to get a list of supported commands).

The implementation is rather limited since the only thing it is used for
is to authenticate to WLAN networks that support the EAP-SIM
authentication method.

Johan


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

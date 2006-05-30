Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <447C6278.1040707@palmsource.com>
Date: Tue, 30 May 2006 17:19:20 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] A2DP Profile Certification
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Brad,

I've just read the "Profile ICS for A2DP" that provides information on =

what is mandatory in order to get this profile certified.
We are only concerned about A2DP Source features and the ICS requires =

the following.

- Initiate Connection Establishment,
- Initiate Start Streaming,
- Initiate Connection Release,
- Start Audio Stream,
- SBC encoder,
- Accept Connection Establishment,
- Accept Start Streaming,
- Accept Connection Release.

- An entry must also appear in SDP records.

The five first points are already provided by the bluetooth-alsa plugin.
Do you have an idea of what can be done in order to satisfy the other =

requirements?

Thank you,
Fr=E9d=E9ric



_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

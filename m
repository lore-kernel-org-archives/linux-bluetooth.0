Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 25 Nov 2013 13:17:56 -0800
Message-ID: <CAHZ1yC=Tx=4zRL_rV0-b-sqhQCO=AmXzCy93Q5jnb2=z2Kr6KQ@mail.gmail.com>
Subject: SM: is BlueZ the Master/Initiator or Slave/Responder?
From: Scott James Remnant <keybuk@google.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Holtmann, Marcel" <marcel.holtmann@intel.com>,
	Johan Hedberg <johan.hedberg@intel.com>,
	Brian Gix <bgix@codeaurora.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We are able to pass all qualification tests with BlueZ as the Master except one:

  TP/KDU/BV-06-C - Master Key Distribution - Encryption Key bit

This test requires that BlueZ initiates pairing with the
SMP_DIST_ENC_KEY bit set in the init_key_dist member of struct
smp_cmd_pairing - however this member is always initialized to zero
and never changed.

This seems to have changed at some point in the past, 2b64d153 added
MITM mechanism and changed the init_key_dist member initialization
from dist_keys to 0


So two questions:

 1) should BlueZ be able to behave as Master? It passes the majority
of the tests except this one.

 2) given the above, is this a bug that init_key_dist is 0 or is it a
test plan error that it requires this?

Scott
-- 
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google

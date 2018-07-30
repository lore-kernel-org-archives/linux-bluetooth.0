Return-Path: <andrea.parri@amarulasolutions.com>
Date: Mon, 30 Jul 2018 05:10:30 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeffy Chen <jeffy.chen@rock-chips.com>,
	Brian Norris <briannorris@chromium.org>,
	AL Yu-Chen Cho <acho@suse.com>
Subject: [Question] bluetooth/{bnep,cmtp,hidp}: memory barriers
Message-ID: <20180730031030.GA9430@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm currently puzzled by the the three calls to smp_mb__before_atomic()
in bnep_session(), cmtp_session() and hidp_session_run() respectively:

On the one hand, these barriers provide no guarantee on the subsequent
atomic_read(s->terminate) (as the comments preceding the barriers seem
to suggest), because atomic_read() is not a read-modify-write.

On the other hand, I'm currently unable to say *why such an "mb" would
be required: not being too familiar with this code, I figured I should
ask before sending a patch.  ;-)

  Andrea

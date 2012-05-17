Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 May 2012 20:52:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alex Elsayed <eternaleye@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4] Add dbus service file that references the systemd unit
Message-ID: <20120517175239.GA26353@x220.P-661HNU-F1>
References: <3754404.7KqlubBV4t@arkadios>
 <8a401753379e62beba65d277ad3d360280386463.1337273908.git.eternaleye@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8a401753379e62beba65d277ad3d360280386463.1337273908.git.eternaleye@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Thu, May 17, 2012, Alex Elsayed wrote:
> This allows bluez to be bus-activated.
> ---
> v4: Drop Exec= from dbus service (only systemd activation supported)
> v3: Use alias as SystemdService so 'systemctl enable/disable' works
> v2: Fix whitespace error
> 
>  Makefile.am              |    2 ++
>  src/bluetooth.service.in |    1 +
>  src/org.bluez.service    |    5 +++++
>  3 files changed, 8 insertions(+)
>  create mode 100644 src/org.bluez.service

Applied. Thanks.

Johan

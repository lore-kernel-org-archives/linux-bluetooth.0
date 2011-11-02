Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1319475848-4171-1-git-send-email-sancane@gmail.com>
References: <1319475848-4171-1-git-send-email-sancane@gmail.com>
Date: Wed, 2 Nov 2011 10:59:37 +0100
Message-ID: <CACLukz+pg_ncY_nd-7j46KUdet=r5uMvQpy_8JRR-eLNFP=FXA@mail.gmail.com>
Subject: Re: Health Thermometer Profile
From: Santiago Carot <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2011/10/24 Santiago Carot-Nemesio <sancane@gmail.com>:
> This set of patches enable applications to register watchers in order to
> receive final measurements. Besides, all fixes suggested in the mailing
> list have been applied.
>
> [PATCH 1/8] Process characteristic descriptors in the thermometer
> [PATCH 2/8] Get valid range descriptor if it is supported
> [PATCH 3/8] Implement D-Bus register watcher function
> [PATCH 4/8] Implement D-Bus unregister watcher function
> [PATCH 5/8] Enable final measurement indications when first watcher
> [PATCH 6/8] Disable final measurements indication when last watcher
> [PATCH 7/8] Manage watcher's disconnections from the bus
> [PATCH 8/8] Implement D-Bus get properties function
>

ping

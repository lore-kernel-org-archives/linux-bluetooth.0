Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1324978182-5707-1-git-send-email-sancane@gmail.com>
References: <1324978182-5707-1-git-send-email-sancane@gmail.com>
Date: Tue, 27 Dec 2011 15:46:56 +0100
Message-ID: <CACLukz+FjR=Pq_5G1FOj7J1C2+PdK39pf+Jj4m-1J7tC6adR=A@mail.gmail.com>
Subject: Re: Multi-adapter GATT server support
From: Santiago Carot <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

2011/12/27 Santiago Carot-Nemesio <sancane@gmail.com>:
> These set of patches completes multi-adapter GATT server support.
> They depend on the latest patches sent on December the 20th.
> These patches change the gatt server interface to provide a new
> paramenter that is the adapter in which the operation takes place.
>
> The only pending task after applying these pacthes is to refactor
> the code for GATT server plugins in order to register their attributes
> whenever an adapter is plugged instead of doing that when the plugin
> is loaded.
>
> Plugins what will need a refactorization after this set of patches are
> time and proximity. Example plugin is already fixed.
>
> [PATCH 1/8] attrib-server: Add blutooth adapter to
> [PATCH 2/8] attrib-server: Add bluetooth adapter in attrib_db_add
> [PATCH 3/8] gatt-service: Add bluetooth adapter in gatt_service_add
> [PATCH 4/8] attrib-server: Add bluetooth adapter in attrib_db_update
> [PATCH 5/8] attrib-server: Add bluetooth adapter in attrib_gap_set
> [PATCH 6/8] attrib-server: Add bluetooth adapter in attrib_db_del
> [PATCH 7/8] attrib-server: Add bluetooth adapter in
> [PATCH 8/8] attrib-server: Add Gattrib in attrib_channel_detach

Please, ignore this set of patches because it requires some
modifications after making the changes suggested for the patches wich
this set depends on, so they will result in conflicts when applying.

I'll send another set fixing this issue.
Regards.

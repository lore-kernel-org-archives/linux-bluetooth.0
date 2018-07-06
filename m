Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH BlueZ v5 14/14] Makefile for meshd
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180706171306.13501-15-brian.gix@intel.com>
Date: Fri, 6 Jul 2018 19:23:33 +0200
Cc: linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        inga.stotland@intel.com
Message-Id: <009670E5-C93B-4B7B-B5BF-BE1B1405CFE8@holtmann.org>
References: <20180706171306.13501-1-brian.gix@intel.com>
 <20180706171306.13501-15-brian.gix@intel.com>
To: Brian Gix <brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

> ---
> Makefile.am   |  1 +
> Makefile.mesh | 44 ++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 45 insertions(+)
> create mode 100644 Makefile.mesh
> 
> diff --git a/Makefile.am b/Makefile.am
> index 2c9490f5f..0ccf393c6 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -235,6 +235,7 @@ unit_tests =
> include Makefile.tools
> include Makefile.obexd
> include android/Makefile.am
> +include Makefile.mesh
> 
> if HID2HCI
> rulesdir = @UDEV_DIR@/rules.d
> diff --git a/Makefile.mesh b/Makefile.mesh
> new file mode 100644
> index 000000000..aaf337579
> --- /dev/null
> +++ b/Makefile.mesh
> @@ -0,0 +1,44 @@
> +if MESH
> +mesh_json_sources = mesh/mesh-db.h mesh/mesh-db.c

why are these split? Do you plan a version that doesn't require JSON?

> +mesh_common_sources = mesh/mesh-defs.h \
> +					mesh/util.h mesh/util.c
> +
> +mesh_sources = $(mesh_common_sources) $(mesh_json_sources) \
> +				mesh/mesh.h mesh/mesh.c \
> +				mesh/mesh-io.h mesh/mesh-io.c \
> +				mesh/mesh-io-api.h mesh/bt.h \
> +				mesh/mesh-io-generic.h \
> +				mesh/mesh-io-generic.c \
> +				mesh/hci.h mesh/hci.c \
> +				mesh/storage.h mesh/storage.c \
> +				mesh/net.h mesh/net.c \
> +				mesh/display.h mesh/display.c \
> +				mesh/crypto.h mesh/crypto.c \
> +				mesh/friend.h mesh/friend.c \
> +				mesh/appkeys.h mesh/appkey.c \
> +				mesh/node.h mesh/node.c \
> +				mesh/prov.h mesh/prov.c \
> +				mesh/provision.h mesh/provision.c \
> +				mesh/model.h mesh/model.c \
> +				mesh/cfgmod.h mesh/cfgmod-server.c
> +
> +libexec_PROGRAMS += mesh/meshd
> +
> +mesh_meshd_SOURCES = $(mesh_sources) \
> +						mesh/main.c

Move it on the same line here.

> +
> +mesh_meshd_LDADD = /usr/lib64/libell.la src/shared/ecc.lo \
> +			@DBUS_LIBS@ -lell -ljson-c -ldl

The /usr/lib64/libell.la is wrong. It is not portable. @ELL_LIBS@ is needed here. Also what is the -ldl for?

> +
> +noinst_PROGRAMS += mesh/btmesh
> +
> +mesh_btmesh_SOURCES = $(mesh_sources) \
> +						mesh/agent.h \
> +						mesh/agent.c \
> +						mesh/btmesh.c
> +
> +mesh_btmesh_LDADD = /usr/lib64/libell.la src/shared/ecc.lo \
> +						src/libshared-mainloop.la \
> +						-lreadline -lell -ljson-c -ldl
> +
> +endif

Regards

Marcel


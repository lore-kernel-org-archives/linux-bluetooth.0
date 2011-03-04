Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1299251315-2041-1-git-send-email-szymon.janc@tieto.com>
References: <1299251315-2041-1-git-send-email-szymon.janc@tieto.com>
Date: Fri, 4 Mar 2011 15:17:53 -0300
Message-ID: <AANLkTinhJ2Omcj2s5Um8ARxhG1fVcwEEqH8uF-=dioMx@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Support for out of band association model
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Mar 4, 2011 at 12:08 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Significant change since last version is that oob data is now fed to kernel (or
> hciops) and is used while pairing if needed. No need for requesting
> providers/agent while pairing. Advantage is less roundtrips and much simpler
> implementation.
>
> Whats in the patchset:
> - for new kernels implementation in mgmtops
>  (with kernel patches from "[PATCH v2 0/4] Support for OOB in mgmt interface")
> - for compatibility with older kernels implementation in hciops (mimic mgmt)
> - D-Bus plugin only exposes OOB functionality. In future we could also have
>  CreateOOB[Paired]Device (or similar) which would act as
>  AddRemoteOobData+CreateDevice.

What happened to the idea of changing CreateDevice to take a
dictionary as we discussed in irc? I guess this is the main point of
the OOB since with this implementation any process can overwrite the
OOB data of a remote device which is not safe, once we have OOB we
should try to pair to check if the data is really valid. The drawback
is that it breaks the current API but I guess we should be focusing on
BlueZ 5.x pretty soon.

> As usual, comments are welcome.
>
>
> BR,
> Szymon Janc
> on behalf of ST-Ericsson
>
>
> Szymon Janc (6):
>  Add initial support for Out of Band (OOB) association model
>  Add support for Out of Band (OOB) association model in mgmtops
>  Add support for Out of Band (OOB) association model in hciops
>  Add D-Bus OOB plugin
>  Update mgmt-api.txt with OOB commands
>  Add oob-api.txt with documentation about OOB D-Bus methods
>
>  Makefile.am       |    8 ++-
>  acinclude.m4      |    6 ++
>  doc/mgmt-api.txt  |   30 +++++++
>  doc/oob-api.txt   |   38 +++++++++
>  lib/mgmt.h        |   18 ++++
>  plugins/dbusoob.c |  241 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  plugins/hciops.c  |  143 ++++++++++++++++++++++++++++++-
>  plugins/mgmtops.c |  127 ++++++++++++++++++++++++++++
>  src/adapter.c     |   18 ++++
>  src/adapter.h     |   12 +++
>  src/oob.c         |   43 ++++++++++
>  src/oob.h         |   30 +++++++
>  12 files changed, 708 insertions(+), 6 deletions(-)
>  create mode 100644 doc/oob-api.txt
>  create mode 100644 plugins/dbusoob.c
>  create mode 100644 src/oob.c
>  create mode 100644 src/oob.h
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Luiz Augusto von Dentz
Computer Engineer

Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <2402684.4YO8nOF4mN@ix>
References: <20170814190119.8684-1-brian.gix@intel.com> <2402684.4YO8nOF4mN@ix>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 16 Aug 2017 15:30:34 +0300
Message-ID: <CABBYNZLtTj0t4Vf8KgCU6wZ0QXM0cmoVd73pGwsLnzWutUoUXQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] MeshCtl - Mesh GATT Client Provisioner
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: Brian Gix <brian.gix@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Aug 16, 2017 at 3:28 PM, Szymon Janc <szymon.janc@codecoup.pl> wrote:
> Hi Brian,
>
> On Monday, 14 August 2017 21:01:14 CEST Brian Gix wrote:
>> With the recent adoption of the Bluetooth Mesh Profile, we offer this
>> GATT Client provisioner tool (meshctl).
>>
>> Brian Gix / Inga Stotland` (5):
>>   mesh: Add BT SIG reserved numbers for Mesh
>>   mesh: define APIs for Bluetooth Mesh
>>   mesh: Baseline Mesh runtime configuration files
>>   mesh: Baseline Mesh implementation
>>   mesh: Add mesh to main bluez build
>>
>>  Makefile.tools       |   24 +
>>  bootstrap-configure  |    1 +
>>  configure.ac         |   18 +
>>  lib/uuid.h           |   10 +
>>  mesh/README          |   26 +
>>  mesh/agent.c         |  276 ++++++
>>  mesh/agent.h         |   58 ++
>>  mesh/config-client.c |  667 +++++++++++++++
>>  mesh/config-model.h  |  119 +++
>>  mesh/config-server.c |  165 ++++
>>  mesh/crypto.c        | 1168 ++++++++++++++++++++++++++
>>  mesh/crypto.h        |  133 +++
>>  mesh/gatt.c          |  609 ++++++++++++++
>>  mesh/gatt.h          |   47 ++
>>  mesh/keys.h          |   43 +
>>  mesh/local_node.json |   61 ++
>>  mesh/main.c          | 2269
>> ++++++++++++++++++++++++++++++++++++++++++++++++++ mesh/mesh-net.h      |
>> 174 ++++
>>  mesh/net.c           | 2184
>> ++++++++++++++++++++++++++++++++++++++++++++++++ mesh/net.h           |
>> 72 ++
>>  mesh/node.c          |  879 +++++++++++++++++++
>>  mesh/node.h          |  146 ++++
>>  mesh/onoff-model.c   |  306 +++++++
>>  mesh/onoff-model.h   |   50 ++
>>  mesh/prov-db.c       | 1599 +++++++++++++++++++++++++++++++++++
>>  mesh/prov-db.h       |   52 ++
>>  mesh/prov.c          |  664 +++++++++++++++
>>  mesh/prov.h          |   43 +
>>  mesh/prov_db.json    |   37 +
>>  mesh/util.c          |  369 ++++++++
>>  mesh/util.h          |   71 ++
>>  31 files changed, 12340 insertions(+)
>>  create mode 100644 mesh/README
>>  create mode 100644 mesh/agent.c
>>  create mode 100644 mesh/agent.h
>>  create mode 100644 mesh/config-client.c
>>  create mode 100644 mesh/config-model.h
>>  create mode 100644 mesh/config-server.c
>>  create mode 100644 mesh/crypto.c
>>  create mode 100644 mesh/crypto.h
>>  create mode 100644 mesh/gatt.c
>>  create mode 100644 mesh/gatt.h
>>  create mode 100644 mesh/keys.h
>>  create mode 100644 mesh/local_node.json
>>  create mode 100644 mesh/main.c
>>  create mode 100644 mesh/mesh-net.h
>>  create mode 100644 mesh/net.c
>>  create mode 100644 mesh/net.h
>>  create mode 100644 mesh/node.c
>>  create mode 100644 mesh/node.h
>>  create mode 100644 mesh/onoff-model.c
>>  create mode 100644 mesh/onoff-model.h
>>  create mode 100644 mesh/prov-db.c
>>  create mode 100644 mesh/prov-db.h
>>  create mode 100644 mesh/prov.c
>>  create mode 100644 mesh/prov.h
>>  create mode 100644 mesh/prov_db.json
>>  create mode 100644 mesh/util.c
>>  create mode 100644 mesh/util.h
>
> Seems like 4th patch didn't make it to the list. Looking at code size it seems
> like it is too big and was rejected by vger. Would it be possible to upload
> this code eg to gihub?

Or CC you as well.

-- 
Luiz Augusto von Dentz

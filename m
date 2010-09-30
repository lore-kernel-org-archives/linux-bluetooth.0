Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTinG4Bpq7uo7v8OrSLjozjJG4XOviGuTnaSbS_Nz@mail.gmail.com>
References: <AANLkTinG4Bpq7uo7v8OrSLjozjJG4XOviGuTnaSbS_Nz@mail.gmail.com>
Date: Thu, 30 Sep 2010 17:34:43 -0300
Message-ID: <AANLkTi=m3MrgF=mJ54wMVH+0b5O9jwciw-HcChpF7HiG@mail.gmail.com>
Subject: Re: Pull request: git://git.infradead.org/users/cktakahasi/bluez.git for-upstream-attrib
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: CLAUDIO TAKAHASI <CLAUDIO.TAKAHASI@openbossa.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Sep 30, 2010 at 11:24 AM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> The following changes since commit b5c556ef59a9a8318b239453c3d4a8aad951689f:
>
>  Move adapter address reading to hciops (2010-09-29 16:34:55 +0300)
>
> are available in the git repository at:
>  git://git.infradead.org/users/cktakahasi/bluez.git for-upstream-attrib
>
> Bruna Moreira (1):
>      Use bt_io_connect in gatttool
>
> Claudio Takahasi (4):
>      Add L2CAP fixed channels support for BTIO
>      Add characteristic SetProperty implementation
>      Fix invalid read and memory leak in the attribute server
>      Fix left open socket warning for attribute server
>
> Gustavo F. Padovan (1):
>      l2test: add support to the fixed channels
>
> Vinicius Costa Gomes (5):
>      Fix filtering out LE events
>      Add support for LE connections to gatttool
>      Add support for LE connections to the GATT server
>      Fix ValueChanged not being called on registered agents
>      Add "Services" property in the org.bluez.Device interface
>
>  Makefile.am         |    2 +-
>  attrib/client.c     |  122 +++++++++++++++++++++++++++++++++++++++------------
>  attrib/client.h     |    5 +-
>  attrib/gatttool.c   |  121 +++++++++++++++-----------------------------------
>  attrib/manager.c    |   12 +----
>  btio/btio.c         |   37 +++++++++++----
>  btio/btio.h         |    1 +
>  src/adapter.c       |    3 +
>  src/attrib-server.c |   29 ++++++++++--
>  src/device.c        |   29 ++++++++++--
>  src/device.h        |    1 +
>  src/security.c      |    1 +
>  test/l2test.c       |   26 +++++++++--
>  13 files changed, 238 insertions(+), 151 deletions(-)
>

New pull request, patches rebased!

The following changes since commit f7b4b3fcd1190d231b864730c821b98fb945e439:

  Move connection list fetching to hciops (2010-09-30 22:12:37 +0300)

are available in the git repository at:
  git://git.infradead.org/users/cktakahasi/bluez.git for-upstream-attrib

Bruna Moreira (1):
      Use bt_io_connect in gatttool

Claudio Takahasi (4):
      Add L2CAP fixed channels support for BTIO
      Add characteristic SetProperty implementation
      Fix invalid read and memory leak in the attribute server
      Fix left open socket warning for attribute server

Gustavo F. Padovan (1):
      l2test: add support to the fixed channels

Vinicius Costa Gomes (5):
      Fix filtering out LE events
      Add support for LE connections to gatttool
      Add support for LE connections to the GATT server
      Fix ValueChanged not being called on registered agents
      Add "Services" property in the org.bluez.Device interface

 Makefile.am         |    2 +-
 attrib/client.c     |  122 +++++++++++++++++++++++++++++++++++++++------------
 attrib/client.h     |    5 +-
 attrib/gatttool.c   |  121 +++++++++++++++-----------------------------------
 attrib/manager.c    |   12 +----
 btio/btio.c         |   37 +++++++++++----
 btio/btio.h         |    1 +
 src/adapter.c       |    3 +
 src/attrib-server.c |   29 ++++++++++--
 src/device.c        |   29 ++++++++++--
 src/device.h        |    1 +
 src/security.c      |    1 +
 test/l2test.c       |   26 +++++++++--
 13 files changed, 238 insertions(+), 151 deletions(-)

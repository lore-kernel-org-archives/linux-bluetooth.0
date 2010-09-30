Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Oct 2010 00:04:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Pull request:
 git://git.infradead.org/users/cktakahasi/bluez.git for-upstream-attrib
Message-ID: <20100930210454.GA28515@jh-x301>
References: <AANLkTinG4Bpq7uo7v8OrSLjozjJG4XOviGuTnaSbS_Nz@mail.gmail.com>
 <AANLkTi=m3MrgF=mJ54wMVH+0b5O9jwciw-HcChpF7HiG@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTi=m3MrgF=mJ54wMVH+0b5O9jwciw-HcChpF7HiG@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Sep 30, 2010, Claudio Takahasi wrote:
> New pull request, patches rebased!
> 
> The following changes since commit f7b4b3fcd1190d231b864730c821b98fb945e439:
> 
>   Move connection list fetching to hciops (2010-09-30 22:12:37 +0300)
> 
> are available in the git repository at:
>   git://git.infradead.org/users/cktakahasi/bluez.git for-upstream-attrib
> 
> Bruna Moreira (1):
>       Use bt_io_connect in gatttool
> 
> Claudio Takahasi (4):
>       Add L2CAP fixed channels support for BTIO
>       Add characteristic SetProperty implementation
>       Fix invalid read and memory leak in the attribute server
>       Fix left open socket warning for attribute server
> 
> Gustavo F. Padovan (1):
>       l2test: add support to the fixed channels
> 
> Vinicius Costa Gomes (5):
>       Fix filtering out LE events
>       Add support for LE connections to gatttool
>       Add support for LE connections to the GATT server
>       Fix ValueChanged not being called on registered agents
>       Add "Services" property in the org.bluez.Device interface
> 
>  Makefile.am         |    2 +-
>  attrib/client.c     |  122 +++++++++++++++++++++++++++++++++++++++------------
>  attrib/client.h     |    5 +-
>  attrib/gatttool.c   |  121 +++++++++++++++-----------------------------------
>  attrib/manager.c    |   12 +----
>  btio/btio.c         |   37 +++++++++++----
>  btio/btio.h         |    1 +
>  src/adapter.c       |    3 +
>  src/attrib-server.c |   29 ++++++++++--
>  src/device.c        |   29 ++++++++++--
>  src/device.h        |    1 +
>  src/security.c      |    1 +
>  test/l2test.c       |   26 +++++++++--
>  13 files changed, 238 insertions(+), 151 deletions(-)

Thanks. All patches have been pushed upstream.

Johan

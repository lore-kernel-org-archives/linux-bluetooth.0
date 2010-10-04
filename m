Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Oct 2010 17:16:28 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Pull request:
 git://gitorious.org/~lizardo/bluez/lizardo-bluez.git for-upstream
Message-ID: <20101004151628.GA19781@jh-x301>
References: <AANLkTimfiie4L6CBm_oTiyFRmB92dt6bugvBREY6vuzN@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimfiie4L6CBm_oTiyFRmB92dt6bugvBREY6vuzN@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Oct 04, 2010, Anderson Lizardo wrote:
> The following changes since commit bb061d925ad661836d5279b543a07d17683d9b6e:
>   Marcel Holtmann (1):
>         Update list of company identifiers
> 
> are available in the git repository at:
> 
>   git://gitorious.org/~lizardo/bluez/lizardo-bluez.git for-upstream
> 
> Anderson Lizardo (7):
>       Remove unnecessary check for watcher path
>       Rename global "handle" variable to "sdp_handle"
>       Add test/test-attrib for testing Attribute API
>       Add org.bluez.Watcher interface to default policy
>       Fix and refactor characteristic value update code
>       Add Write Characteristic Value support to attribute server
>       Allow errors to propagate from connection callback
> 
> Bruna Moreira (8):
>       Add encoders/decoders for the Write command
>       Implement Write command in GATT API
>       Move connection common code to l2cap_connect()
>       Write new value for characteristic value
>       Use g_slist_foreach() instead of a for loop
>       Make handle parameter mandatory in gatttool
>       Add new option for char value write in gatttool
>       Implement characteristic_write callback in gatttool
> 
>  attrib/att.c        |   45 ++++++++++++++++
>  attrib/att.h        |    4 ++
>  attrib/client.c     |  145 ++++++++++++++++++++++++---------------------------
>  attrib/gatt.c       |   11 ++++
>  attrib/gatt.h       |    3 +
>  attrib/gatttool.c   |  120 ++++++++++++++++++++++++++++++++++++------
>  src/attrib-server.c |   32 ++++++++++--
>  src/bluetooth.conf  |    1 +
>  test/test-attrib    |  120 ++++++++++++++++++++++++++++++++++++++++++
>  9 files changed, 381 insertions(+), 100 deletions(-)
>  create mode 100755 test/test-attrib

Thanks, all patches have been pushed upstream.

Johan

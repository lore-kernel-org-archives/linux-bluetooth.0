Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Date: Mon, 11 Oct 2010 14:25:02 +0200
Message-ID: <AANLkTi=Ogzb3kUX7O4fz-w9gNpU9PCyTFo0GnhfePjC6@mail.gmail.com>
Subject: Pull request git://gitorious.org/bluez-mcap-hdp/mcap-hdp.git for_upstream
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The following changes since commit 646f0c7e6b557c5413825ce7b04bee52bf0129e8:

  Move remote name and version requests to hciops (2010-10-10 22:44:25 +0100)

are available in the git repository at:
  git://gitorious.org/bluez-mcap-hdp/mcap-hdp.git for_upstream

José Antonio Santos Cadenas (6):
      Remove mdl_conn from struct hdp_channel
      Remove app paramter from hdp_establish_mcl, it is not needed
      Imcoming connection in control channel should be ERTM
      Fix multiple emission of main channel property signal.
      Return MCAP_MDL_BUSY when health channel can't be created
      Implement callback for responding echo petitions

Santiago Carot-Nemesio (6):
      Add a new function to create channels
      Process request of of echo channels creation
      Correctly notify the deletion of the reliable data channel
      Add extra checks for avoid notifiying incoming echo channels
      Delete all channels DBus interface when the instance is removed
      Check first reliable configuration during channel creation

 health/hdp.c       |  249 +++++++++++++++++++++++++++++++++++----------------
 health/hdp_types.h |    3 +-
 health/hdp_util.c  |    3 -
 health/hdp_util.h  |    1 -
 health/mcap.c      |    1 +
 5 files changed, 174 insertions(+), 83 deletions(-)

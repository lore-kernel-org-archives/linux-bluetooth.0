Return-Path: <cyrus@holtmann.org>
From: Jakub Adamek <adamek.kuba@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Adamek <adamek.kuba@gmail.com>
Subject: [PATCH obexd 00/10] Support user defined headers in gwobex
Date: Sun, 19 Jun 2011 02:59:36 +0200
Message-Id: <1308445186-27135-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

these patches will enable sending and receiving of user defined headers
in gwobex.

Two new functions will enable to start an asynchronous get or put
transfer, taking as an argument a list of structures describing
the headers to be sent. The headers are sent out in the order
of appearance on the list.

Likewise all response headers that would have been previously ignored
by gwobex are now inserted to a list in the current gw_obex_xfer
object, and so can be retrieved later after the asynchrous transfer
has finished.

Additionally, the order of sending headers in gwobex is changed
to the one mandated by BIP, i.e.:
Connection ID->Type->Name->Application Parameters->User Defined Headers.

Jakub Adamek (10):
  Add a_header struct for additional header data
  Add list to store received headers
  Store received headers in gw_obex_xfer object
  Add functions to get, put w. a_header list
  Parse headers in a PUT response packet
  Add functions for async requests w a_header list
  Reorder headers to conform to BIP's requirements
  Handle partial content response from server
  Convenience method to make deep copy of a_header
  Add func for fetching header by id from list

 gwobex/gw-obex.h   |   39 +++++++++++++
 gwobex/obex-priv.c |  151 +++++++++++++++++++++++++++++++++++++---------------
 gwobex/obex-priv.h |   29 ++++++++++
 gwobex/obex-xfer.c |   70 ++++++++++++++++++++++++
 gwobex/obex-xfer.h |   15 +++++
 5 files changed, 261 insertions(+), 43 deletions(-)


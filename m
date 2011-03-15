Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Mar 2011 10:52:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 3/5] Use new UUID functions in GATT
Message-ID: <20110315085205.GB16296@jh-x301>
References: <1300128839-6293-1-git-send-email-epx@signove.com>
 <1300128839-6293-4-git-send-email-epx@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300128839-6293-4-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On Mon, Mar 14, 2011, Elvis Pf??tzenreuter wrote:
> This patch puts the new UUID functions into use for GATT-related
> code, and adds some convenience functions to ATT API (att.h).
> ---
>  attrib/att.c         |   47 +++++++++++--------------
>  attrib/att.h         |   69 +++++++++++++++++++++++++++++++++----
>  attrib/client.c      |   26 ++++++--------
>  attrib/gatt.c        |   68 +++++++++++++++++++------------------
>  attrib/gatt.h        |    4 +-
>  attrib/gattrib.c     |    3 +-
>  attrib/gatttool.c    |   18 ++++-----
>  attrib/interactive.c |   22 +++++------
>  attrib/utils.c       |    1 +
>  src/adapter.c        |    1 +
>  src/attrib-server.c  |   93 +++++++++++++++++++++++++------------------------
>  src/attrib-server.h  |    4 +-
>  src/device.c         |    1 +
>  src/main.c           |    1 +

This one doesn't compile at all:

In file included from attrib/example.c:39:
./src/attrib-server.h:28: error: expected declaration specifiers or '...' before 'bt_uuid_t'
./src/attrib-server.h:30: error: expected declaration specifiers or '...' before 'bt_uuid_t'
In file included from attrib/example.c:41:
attrib/att.h:123: error: expected specifier-qualifier-list before 'bt_uuid_t'
In file included from attrib/example.c:41:
attrib/att.h:208: error: expected ')' before 'src'
attrib/att.h:213: error: expected ')' before 'src'
attrib/att.h:218: error: expected ')' before 'src'
attrib/att.h:226: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'att_get_uuid16'
attrib/att.h:235: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'att_get_uuid128'
attrib/att.h:250: error: expected declaration specifiers or '...' before 'bt_uuid_t'
attrib/att.h:253: error: expected declaration specifiers or '...' before 'bt_uuid_t'
attrib/att.h:255: error: expected declaration specifiers or '...' before 'bt_uuid_t'
attrib/att.h:258: error: expected declaration specifiers or '...' before 'bt_uuid_t'
attrib/att.h:262: error: expected declaration specifiers or '...' before 'bt_uuid_t'
attrib/att.h:265: error: expected declaration specifiers or '...' before 'bt_uuid_t'
cc1: warnings being treated as errors
attrib/example.c: In function 'register_attributes':
attrib/example.c:87: error: passing argument 2 of 'attrib_db_add' makes integer from pointer without a cast
./src/attrib-server.h:28: note: expected 'int' but argument is of type 'struct uuid_t *'
...

Please at least do a basic compilation test before submitting patches ;)

Johan

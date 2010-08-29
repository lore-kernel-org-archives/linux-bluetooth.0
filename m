Return-Path: <cyrus@holtmann.org>
From: "Ho, Albert O" <albert.o.ho@intel.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"marcel@holtmann.org" <marcel@holtmann.org>
Date: Sat, 28 Aug 2010 22:18:50 -0700
Subject: RE: Cannot build BlueZ Release 4.70...
Message-ID: <CF9C39F99A89134C9CF9C4CCB68B8DDF25AB2D28E0@orsmsx501.amr.corp.intel.com>
References: <CF9C39F99A89134C9CF9C4CCB68B8DDF25AB2D2864@orsmsx501.amr.corp.intel.com>
 <20100828082256.GA23228@jh-x301>
In-Reply-To: <20100828082256.GA23228@jh-x301>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

The configure line invocation is taken from README file.  Below are copy-pa=
ste exact errors.

Regards,
Albert


src/attrib-server.o: In function `send_notification':
attrib-server.c:(.text+0x1da): undefined reference to `enc_notification'
attrib-server.c:(.text+0x211): undefined reference to `g_attrib_send'
src/attrib-server.o: In function `connect_event':
attrib-server.c:(.text+0x863): undefined reference to `g_attrib_new'
attrib-server.c:(.text+0x885): undefined reference to `g_attrib_register'
src/attrib-server.o: In function `channel_destroy':
attrib-server.c:(.text+0x8b9): undefined reference to `g_attrib_unregister_=
all'
attrib-server.c:(.text+0x8c2): undefined reference to `g_attrib_unref'
src/attrib-server.o: In function `channel_handler':
attrib-server.c:(.text+0x964): undefined reference to `dec_read_by_grp_req'
attrib-server.c:(.text+0x990): undefined reference to `enc_error_resp'
attrib-server.c:(.text+0x9b2): undefined reference to `g_attrib_send'
attrib-server.c:(.text+0x9e9): undefined reference to `dec_read_req'
attrib-server.c:(.text+0xa39): undefined reference to `enc_read_resp'
attrib-server.c:(.text+0xa64): undefined reference to `dec_read_by_type_req=
'
attrib-server.c:(.text+0xbcc): undefined reference to `enc_read_by_type_res=
p'
attrib-server.c:(.text+0xbd8): undefined reference to `att_data_list_free'
attrib-server.c:(.text+0xc01): undefined reference to `dec_find_info_req'
attrib-server.c:(.text+0xd7b): undefined reference to `enc_find_info_resp'
attrib-server.c:(.text+0xd86): undefined reference to `att_data_list_free'
attrib-server.c:(.text+0xf52): undefined reference to `enc_error_resp'
attrib-server.c:(.text+0xf7c): undefined reference to `enc_error_resp'
attrib-server.c:(.text+0xfac): undefined reference to `enc_error_resp'
attrib-server.c:(.text+0xfd3): undefined reference to `enc_error_resp'
attrib-server.c:(.text+0xff7): undefined reference to `enc_error_resp'
attrib-server.c:(.text+0x1011): undefined reference to `enc_read_by_grp_res=
p'
attrib-server.c:(.text+0x101d): undefined reference to `att_data_list_free'
attrib-server.c:(.text+0x106d): undefined reference to `enc_error_resp'
attrib-server.c:(.text+0x1092): undefined reference to `enc_error_resp'
collect2: ld returned 1 exit status
make[1]: *** [src/bluetoothd] Error 1
make: *** [all] Error 2


-----Original Message-----
From: Johan Hedberg [mailto:johan.hedberg@gmail.com]=20
Sent: Saturday, August 28, 2010 1:23 AM
To: Ho, Albert O
Cc: linux-bluetooth@vger.kernel.org; marcel@holtmann.org
Subject: Re: Cannot build BlueZ Release 4.70...

Hi Albert,

On Sat, Aug 28, 2010, Ho, Albert O wrote:
> Hi, I attempted to build Release 4.70 but it's not buildable.  Using
> sources either from bluez-4.70.tar.gz (www.bluez.org) or from git
> results to compile errors.  The offending lines are all in
> attrib-server.c & all are 'undefined references to xxxxx'.  Same setup
> can build 4.69.  Pls advise.

It compiles fine for me. You'll need to copy-paste the exact errors you
get as well as the configure script options that you used.

Johan

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CF9C39F99A89134C9CF9C4CCB68B8DDF25AB2D28E0@orsmsx501.amr.corp.intel.com>
References: <CF9C39F99A89134C9CF9C4CCB68B8DDF25AB2D2864@orsmsx501.amr.corp.intel.com>
	<20100828082256.GA23228@jh-x301>
	<CF9C39F99A89134C9CF9C4CCB68B8DDF25AB2D28E0@orsmsx501.amr.corp.intel.com>
Date: Sun, 29 Aug 2010 14:15:52 +0530
Message-ID: <AANLkTi=K6rdg+Pck7FjbDP-LTn=5sXrLVX9Nz8RPqi0v@mail.gmail.com>
Subject: Re: Cannot build BlueZ Release 4.70...
From: alok barsode <alokbarsode@gmail.com>
To: "Ho, Albert O" <albert.o.ho@intel.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"marcel@holtmann.org" <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Albert,

On Sun, Aug 29, 2010 at 10:48 AM, Ho, Albert O <albert.o.ho@intel.com> wrot=
e:
> Hi Johan,
>
> The configure line invocation is taken from README file. =A0Below are cop=
y-paste exact errors.

I tried building using bootstrap-configure and it built fine.
But when I tried building with ./bootstrap and ./configure  it gave
the same errors as mentioned.
Maybe we missed some configure option ?

Cheers,
Alok.

>
> Regards,
> Albert
>
>
> src/attrib-server.o: In function `send_notification':
> attrib-server.c:(.text+0x1da): undefined reference to `enc_notification'
> attrib-server.c:(.text+0x211): undefined reference to `g_attrib_send'
> src/attrib-server.o: In function `connect_event':
> attrib-server.c:(.text+0x863): undefined reference to `g_attrib_new'
> attrib-server.c:(.text+0x885): undefined reference to `g_attrib_register'
> src/attrib-server.o: In function `channel_destroy':
> attrib-server.c:(.text+0x8b9): undefined reference to `g_attrib_unregiste=
r_all'
> attrib-server.c:(.text+0x8c2): undefined reference to `g_attrib_unref'
> src/attrib-server.o: In function `channel_handler':
> attrib-server.c:(.text+0x964): undefined reference to `dec_read_by_grp_re=
q'
> attrib-server.c:(.text+0x990): undefined reference to `enc_error_resp'
> attrib-server.c:(.text+0x9b2): undefined reference to `g_attrib_send'
> attrib-server.c:(.text+0x9e9): undefined reference to `dec_read_req'
> attrib-server.c:(.text+0xa39): undefined reference to `enc_read_resp'
> attrib-server.c:(.text+0xa64): undefined reference to `dec_read_by_type_r=
eq'
> attrib-server.c:(.text+0xbcc): undefined reference to `enc_read_by_type_r=
esp'
> attrib-server.c:(.text+0xbd8): undefined reference to `att_data_list_free=
'
> attrib-server.c:(.text+0xc01): undefined reference to `dec_find_info_req'
> attrib-server.c:(.text+0xd7b): undefined reference to `enc_find_info_resp=
'
> attrib-server.c:(.text+0xd86): undefined reference to `att_data_list_free=
'
> attrib-server.c:(.text+0xf52): undefined reference to `enc_error_resp'
> attrib-server.c:(.text+0xf7c): undefined reference to `enc_error_resp'
> attrib-server.c:(.text+0xfac): undefined reference to `enc_error_resp'
> attrib-server.c:(.text+0xfd3): undefined reference to `enc_error_resp'
> attrib-server.c:(.text+0xff7): undefined reference to `enc_error_resp'
> attrib-server.c:(.text+0x1011): undefined reference to `enc_read_by_grp_r=
esp'
> attrib-server.c:(.text+0x101d): undefined reference to `att_data_list_fre=
e'
> attrib-server.c:(.text+0x106d): undefined reference to `enc_error_resp'
> attrib-server.c:(.text+0x1092): undefined reference to `enc_error_resp'
> collect2: ld returned 1 exit status
> make[1]: *** [src/bluetoothd] Error 1
> make: *** [all] Error 2
>
>
> -----Original Message-----
> From: Johan Hedberg [mailto:johan.hedberg@gmail.com]
> Sent: Saturday, August 28, 2010 1:23 AM
> To: Ho, Albert O
> Cc: linux-bluetooth@vger.kernel.org; marcel@holtmann.org
> Subject: Re: Cannot build BlueZ Release 4.70...
>
> Hi Albert,
>
> On Sat, Aug 28, 2010, Ho, Albert O wrote:
>> Hi, I attempted to build Release 4.70 but it's not buildable. =A0Using
>> sources either from bluez-4.70.tar.gz (www.bluez.org) or from git
>> results to compile errors. =A0The offending lines are all in
>> attrib-server.c & all are 'undefined references to xxxxx'. =A0Same setup
>> can build 4.69. =A0Pls advise.
>
> It compiles fine for me. You'll need to copy-paste the exact errors you
> get as well as the configure script options that you used.
>
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1301398615-16283-3-git-send-email-luiz.dentz@gmail.com>
References: <1301398615-16283-1-git-send-email-luiz.dentz@gmail.com>
	<1301398615-16283-3-git-send-email-luiz.dentz@gmail.com>
Date: Tue, 29 Mar 2011 09:10:22 -0400
Message-ID: <AANLkTi=0E9vJfTODGVxLd3dY1E_8aauP9+dA0Z0qDQVH@mail.gmail.com>
Subject: Re: [PATCH 3/3] Fix uninitialized variables warnings
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Mar 29, 2011 at 7:36 AM,  <luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
>
> src/attrib-server.c: In function ‘channel_handler’:
> src/attrib-server.c:297:21: error: ‘cur’ may be used uninitialized in this function
> src/attrib-server.c:502:10: error: ‘format’ may be used uninitialized in this function
> src/attrib-server.c:503:11: error: ‘length’ may be used uninitialized in this function
> make[1]: *** [src/attrib-server.o] Error 1

Can you mention which compiler are you using ? Is it the just released
4.6.1 ? Or clang ? I'd like to use it as well.

Also I think that at least for this attrib-server.c patch, it is
hiding some real bugs (missing checks). I can't talk for the other
files though :)

E.g., if the attribute database is empty (highly unlikely, as it will
contain at least the GAP attributes), this will dereference a NULL
pointer:

    if (l == NULL)
        cur->end = a->handle;
    else
        cur->end = last_handle;


Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

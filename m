Return-Path: <jt@bougret.hpl.hp.com>
Date: Tue, 16 Sep 2003 12:53:33 -0700
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Stephen Crane <steve.crane@rococosoft.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] More SDP UUIDs...
Message-ID: <20030916195333.GA25068@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030915221624.GA17085@bougret.hpl.hp.com> <1063712005.22723.27.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1063712005.22723.27.camel@pegasus>
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Tue, Sep 16, 2003 at 01:33:20PM +0200, Marcel Holtmann wrote:
> Hi Jean,
> 
> > 	I've just realised that you didn't keep the UUID and attribute
> > list of sdptool in sync. The patch below correct this.
> 
> I have applied your patch, thanks.

	While you are at it, would you mid to do the following :
	o rename sdp_uuid_cmp() to sdp_uuid128_cmp(). The current name
totally confused me.
	o add in the library the following function :
------------------------------------------------
/*
 * UUID comparison function
 * returns 0 if uuidValue1 == uuidValue2 else -1
 */
int sdp_uuid16_cmp(const void *p1, const void *p2)
{
	const uuid_t *u1 = (const uuid_t *)p1;
	const uuid_t *u2 = (const uuid_t *)p2;
	return memcmp(&u1->value.uuid16, &u2->value.uuid16, sizeof(uint16_t));
}
------------------------------------------------

> > 	Also : I believe that having in the sdp library all the
> > functions xxx2str() (uuid2str, sdp_proto_uuid2strn...) and their
> > associated data (struct tupla ServiceClass...) is not
> > necessary.
> > 	Realistically, only sdptool or a graphical equivalent would
> > use those functions, the vast majority of users of the library would
> > be like 'pand' and only create or search SDP records.
> > 	Moving this functionality to sdptool would allow to reduce
> > further the size of the SDP library.
> 
> I like to keep this functions in the library, because they are a good
> for debugging and they can be shared between any graphical and terminal
> SDP tools. Anyway it seems to me like a good idea to have a compile
> switch to disable the string arrays and let the functions return NULL
> instead. People which care about the library size can use it.

	Or make it two libraries.

> My work on the 4th (or maybe 5th) generation of a SDP library is making
> good progress and I hope that I will have clean code for publishing very
> soon.

	I hope you will keep the --tree browsing option in sdptool,
because the default browsing is useless for advanced stuff. The
display might be ugly, but at least it display everything and the
basic infrastructure is sound.

> Regards
> 
> Marcel

	Have fun...

	Jean

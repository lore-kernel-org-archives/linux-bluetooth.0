Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] starting btsco-in-libalsa
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41B81ACB.1080807@xmission.com>
References: <41B81ACB.1080807@xmission.com>
Content-Type: multipart/mixed; boundary="=-K59go3RISiZe+2dgS5LZ"
Message-Id: <1102589835.9988.114.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 09 Dec 2004 11:57:15 +0100


--=-K59go3RISiZe+2dgS5LZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Brad,

> I put some junk in the btsco cvs:
> 
> alsa-lib.patch
> bt/
> 
> if you apply alsa-lib.patch and put bt inside alsa-lib/src/pcm then the 
> idea is that you can build a userspace alsa driver.
> 
> currently it doesn't even compile... it's just based on the jack plugin 
> and not yet reworked for bluetooth.

nice start. Actually I tried this by myself some time ago, but haven't
got any further than a skeleton. The main problem I see at the moment is
that we have to develop this inside the ALSA lib source and that is bad.
The reason for this is "pcm_local.h" and its definitions that are not
installed system wide. I don't think that SND_PCM_TYPE_BLUETOOTH is
needed, but I can be wrong of course. The other thing is that this stuff
should belong to the pcm/ext/ directory. My skeleton is attached and I
used these extra lines in ~/.asoundrc

	pcm.aiptek {
		type a2dp
		bdaddr "00:0B:xx:xx:xx:xx"
	}

Assuming that /usr/lib/alsa-lib/libasound_module_pcm_a2dp.so exists this
works as it should. So we have PCM at the input side of this plugin and
we send SBC over AVDTP to our headphone.

> anyway, this is my next project. it depends on a couple of things in 
> other parts of the project:

Actually I think this is the way we should go. Using a2play is great,
but this will open it up to any tool that can play music using the ALSA
library.

>   it would be nice if 'make install' inside sbc/ would install the sbc 
> includes and library (static libs would be ok)

This is the whole goal, but for now I think we should copy the source
and simply link it. My plan is to combine sbclib.c and sbc.c and include
sbc_internal.h into sbc.c then. Also sbc_tables.h is not really useful
as a separate include.

>   the avdtp library is just a skeleton right now... should I just ignore 
> it for now and hardcode what is currently in a2play?

It is more than a skeleton, but I haven't committed the other code and I
don't think that I will have much time to work on it. Ignore it for now,
because we can catch up with that later.

Regards

Marcel


--=-K59go3RISiZe+2dgS5LZ
Content-Disposition: attachment; filename=pcm_a2dp.c
Content-Type: text/x-csrc; name=pcm_a2dp.c; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

/*
 *
 *  Bluetooth Advanced Audio Distribution Profile (A2DP) plugin
 *
 *  Copyright (C) 2004  Marcel Holtmann <marcel@holtmann.org>
 *
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <sys/types.h>
#include <sys/socket.h>

#include <bluetooth/bluetooth.h>

#include "sbc.h"

#include "pcm_local.h"

#define DBG(fmt, arg...)  printf("%s: " fmt "\n" , __FUNCTION__ , ## arg)

#ifndef PIC
/* entry for static linking */
const char *_snd_module_pcm_a2dp = "";
#endif

static int snd_pcm_a2dp_close(snd_pcm_t *pcm)
{
	DBG("pcm %p", pcm);

	return 0;
}

static int snd_pcm_a2dp_nonblock(snd_pcm_t *pcm, int nonblock)
{
	DBG("pcm %p nonblock %d", pcm, nonblock);

	return 0;
}

static int snd_pcm_a2dp_async(snd_pcm_t *pcm, int sig, pid_t pid)
{
	DBG("pcm %p sig %d pid %d", pcm, sig, pid);

	return -ENOSYS;
}

static int snd_pcm_a2dp_poll_revents(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int nfds, unsigned short *revents)
{
	DBG("pcm %p pfds %p nfds %d revents %p", pcm, pfds, nfds, revents);

	return 0;
}

static int snd_pcm_a2dp_info(snd_pcm_t *pcm, snd_pcm_info_t *info)
{
	DBG("pcm %p info %p", pcm, info);

	memset(info, 0, sizeof(*info));
	info->stream = pcm->stream;
	info->card = -1;
	strncpy(info->id, pcm->name, sizeof(info->id));
	strncpy(info->name, pcm->name, sizeof(info->name));
	strncpy(info->subname, pcm->name, sizeof(info->subname));
	info->subdevices_count = 1;

	return 0;
}

static inline snd_mask_t *hw_param_mask(snd_pcm_hw_params_t *params, snd_pcm_hw_param_t var)
{
	return &params->masks[var - SND_PCM_HW_PARAM_FIRST_MASK];
}

static inline snd_interval_t *hw_param_interval(snd_pcm_hw_params_t *params, snd_pcm_hw_param_t var)
{
	return &params->intervals[var - SND_PCM_HW_PARAM_FIRST_INTERVAL];
}

static int snd_pcm_a2dp_hw_refine(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
{
	static snd_mask_t access = { .bits = { 
					(1<<SNDRV_PCM_ACCESS_MMAP_INTERLEAVED) |
					(1<<SNDRV_PCM_ACCESS_MMAP_NONINTERLEAVED) |
					(1<<SNDRV_PCM_ACCESS_RW_INTERLEAVED) |
					(1<<SNDRV_PCM_ACCESS_RW_NONINTERLEAVED),
					0, 0, 0 } };
	static snd_pcm_format_mask_t format_mask = { { 1U<<SNDRV_PCM_FORMAT_S16_BE } };
	snd_interval_t t;
	int err;

	DBG("pcm %p params %p", pcm, params);

	err = snd_mask_refine(hw_param_mask(params, SND_PCM_HW_PARAM_ACCESS), &access);
	if (err < 0)
		return err;

	err = snd_mask_refine(hw_param_mask(params, SND_PCM_HW_PARAM_FORMAT), &format_mask);
	if (err < 0)
		return err;

	err = snd_interval_refine_set(hw_param_interval(params, SND_PCM_HW_PARAM_CHANNELS), 2);
	if (err < 0)
		return err;

	err = snd_interval_refine_set(hw_param_interval(params, SND_PCM_HW_PARAM_RATE), 44100);
	if (err < 0)
		return err;

	snd_interval_set_minmax(&t, 128, 1024*1024);
	err = snd_interval_refine(hw_param_interval(params, SND_PCM_HW_PARAM_BUFFER_SIZE), &t);
	if (err < 0)
		return err;

	snd_interval_set_minmax(&t, 64, 1024*1024);
	err = snd_interval_refine(hw_param_interval(params, SND_PCM_HW_PARAM_PERIOD_SIZE), &t);
	if (err < 0)
		return err;

	snd_interval_set_minmax(&t, 2, 64);
	err = snd_interval_refine(hw_param_interval(params, SND_PCM_HW_PARAM_PERIODS), &t);
	if (err < 0)
		return err;

	return 0;
}

static int snd_pcm_a2dp_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
{
	DBG("pcm %p params %p", pcm, params);

	return 0;
}

static int snd_pcm_a2dp_hw_free(snd_pcm_t *pcm)
{
	DBG("pcm %p", pcm);

	return 0;
}

static int snd_pcm_a2dp_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t *params)
{
	DBG("pcm %p params %p", pcm, params);

	return 0;
}

static int snd_pcm_a2dp_channel_info(snd_pcm_t *pcm, snd_pcm_channel_info_t *info)
{
	DBG("pcm %p info %p", pcm, info);

	return snd_pcm_channel_info_shm(pcm, info, -1);
}

static void snd_pcm_a2dp_dump(snd_pcm_t *pcm, snd_output_t *out)
{
	DBG("pcm %p out %p", pcm, out);

	snd_output_printf(out, "Bluetooth A2DP PCM\n");
	if (pcm->setup) {
		snd_output_printf(out, "Its setup is:\n");
		snd_pcm_dump_setup(pcm, out);
	}
}

static int snd_pcm_a2dp_mmap(snd_pcm_t *pcm)
{
	DBG("pcm %p", pcm);

	return 0;
}

static int snd_pcm_a2dp_munmap(snd_pcm_t *pcm)
{
	DBG("pcm %p", pcm);

	return 0;
}

static snd_pcm_ops_t snd_pcm_a2dp_ops = {
	.close		= snd_pcm_a2dp_close,
	.info		= snd_pcm_a2dp_info,
	.nonblock	= snd_pcm_a2dp_nonblock,
	.async		= snd_pcm_a2dp_async,
	.poll_revents	= snd_pcm_a2dp_poll_revents,
	.hw_refine	= snd_pcm_a2dp_hw_refine,
	.hw_params	= snd_pcm_a2dp_hw_params,
	.hw_free	= snd_pcm_a2dp_hw_free,
	.sw_params	= snd_pcm_a2dp_sw_params,
	.channel_info	= snd_pcm_a2dp_channel_info,
	.dump		= snd_pcm_a2dp_dump,
	.mmap		= snd_pcm_a2dp_mmap,
	.munmap		= snd_pcm_a2dp_munmap,
};

static int snd_pcm_a2dp_status(snd_pcm_t *pcm, snd_pcm_status_t *status)
{
	DBG("pcm %p status %p", pcm, status);

	memset(status, 0, sizeof(*status));
	status->avail = pcm->buffer_size;

	return 0;
}

static int snd_pcm_a2dp_prepare(snd_pcm_t *pcm)
{
	DBG("pcm %p", pcm);

	return 0;
}

static int snd_pcm_a2dp_reset(snd_pcm_t *pcm)
{
	DBG("pcm %p", pcm);

	return 0;
}

static int snd_pcm_a2dp_start(snd_pcm_t *pcm)
{
	DBG("pcm %p", pcm);

	return 0;
}

static int snd_pcm_a2dp_drop(snd_pcm_t *pcm)
{
	DBG("pcm %p", pcm);

	return 0;
}

static int snd_pcm_a2dp_drain(snd_pcm_t *pcm)
{
	DBG("pcm %p", pcm);

	return 0;
}

static int snd_pcm_a2dp_pause(snd_pcm_t *pcm, int enable)
{
	DBG("pcm %p enable %d", pcm, enable);

	return 0;
}

static snd_pcm_state_t snd_pcm_a2dp_state(snd_pcm_t *pcm)
{
	DBG("pcm %p", pcm);

	return SND_PCM_STATE_RUNNING;
}

static int snd_pcm_a2dp_hwsync(snd_pcm_t *pcm)
{
	DBG("pcm %p", pcm);

	return 0;
}

static int snd_pcm_a2dp_delay(snd_pcm_t *pcm, snd_pcm_sframes_t *delay)
{
	DBG("pcm %p delay %p", pcm, delay);

	return 0;
}

static int snd_pcm_a2dp_resume(snd_pcm_t *pcm)
{
	DBG("pcm %p", pcm);

	return 0;
}

static int snd_pcm_a2dp_poll_ask(snd_pcm_t *pcm)
{
	DBG("pcm %p", pcm);

	return 0;
}

static snd_pcm_sframes_t snd_pcm_a2dp_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
{
	DBG("pcm %p frames %d", pcm, frames);

	return 0;
}

static snd_pcm_sframes_t snd_pcm_a2dp_forward(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
{
	DBG("pcm %p frames %d", pcm, frames);

	return 0;
}

static snd_pcm_sframes_t snd_pcm_a2dp_writei(snd_pcm_t *pcm, const void *buffer, snd_pcm_uframes_t size)
{
	DBG("pcm %p buffer %p size %d", pcm, buffer, size);

	return 0;
}

static snd_pcm_sframes_t snd_pcm_a2dp_writen(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size)
{
	DBG("pcm %p bufs %p size %d", pcm, bufs, size);

	return 0;
}

static snd_pcm_sframes_t snd_pcm_a2dp_readi(snd_pcm_t *pcm, void *buffer, snd_pcm_uframes_t size)
{
	DBG("pcm %p buffer %p size %d", pcm, buffer, size);

	return 0;
}

static snd_pcm_sframes_t snd_pcm_a2dp_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size)
{
	DBG("pcm %p bufs %p size %d", pcm, bufs, size);

	return 0;
}

static snd_pcm_sframes_t snd_pcm_a2dp_avail_update(snd_pcm_t *pcm)
{
	DBG("pcm %p", pcm);

	return 0;
}

static snd_pcm_sframes_t snd_pcm_a2dp_mmap_commit(snd_pcm_t *pcm, snd_pcm_uframes_t offset, snd_pcm_uframes_t size)
{
	DBG("pcm %p offset %d size %d", pcm, offset, size);

	return 0;
}

static snd_pcm_fast_ops_t snd_pcm_a2dp_fast_ops = {
	.status		= snd_pcm_a2dp_status,
	.prepare	= snd_pcm_a2dp_prepare,
	.reset		= snd_pcm_a2dp_reset,
	.start		= snd_pcm_a2dp_start,
	.drop		= snd_pcm_a2dp_drop,
	.drain		= snd_pcm_a2dp_drain,
	.pause		= snd_pcm_a2dp_pause,
	.state		= snd_pcm_a2dp_state,
	.hwsync		= snd_pcm_a2dp_hwsync,
	.delay		= snd_pcm_a2dp_delay,
	.resume		= snd_pcm_a2dp_resume,
	.poll_ask	= snd_pcm_a2dp_poll_ask,
	.rewind		= snd_pcm_a2dp_rewind,
	.forward	= snd_pcm_a2dp_forward,
	.writei		= snd_pcm_a2dp_writei,
	.writen		= snd_pcm_a2dp_writen,
	.readi		= snd_pcm_a2dp_readi,
	.readn		= snd_pcm_a2dp_readn,
	.avail_update	= snd_pcm_a2dp_avail_update,
	.mmap_commit	= snd_pcm_a2dp_mmap_commit,
};

static int snd_pcm_a2dp_open(snd_pcm_t **pcmp, const char *name,
		bdaddr_t *src, bdaddr_t *dst, snd_pcm_stream_t stream, int mode)
{
	snd_pcm_t *pcm;
	char addr[18];
	int err;

	DBG("name %s mode %d", name, mode);

	ba2str(dst, addr);
	printf("BD_ADDR %s\n", addr);

	err = snd_pcm_new(&pcm, SND_PCM_TYPE_HW, name, stream, mode);
	if (err < 0)
		return err;

	pcm->ops = &snd_pcm_a2dp_ops;
	pcm->fast_ops = &snd_pcm_a2dp_fast_ops;

	*pcmp = pcm;

	return 0;
}

int _snd_pcm_a2dp_open(snd_pcm_t **pcmp, const char *name, snd_config_t *root,
			snd_config_t *conf, snd_pcm_stream_t stream, int mode)
{
	snd_config_iterator_t i, next;
	bdaddr_t src, dst;
	const char *addr;
	int err;

	DBG("name %s mode %d", name, mode);

	bacpy(&src, BDADDR_ANY);
	bacpy(&dst, BDADDR_ANY);

	snd_config_for_each(i, next, conf) {
		snd_config_t *n = snd_config_iterator_entry(i);
		const char *id;

		if (snd_config_get_id(n, &id) < 0)
			continue;

		if (snd_pcm_conf_generic_id(id))
			continue;

		if (strcmp(id, "bdaddr") == 0 || strcmp(id, "dst") == 0) {
			if (snd_config_get_type(n) != SND_CONFIG_TYPE_STRING) {
				SNDERR("Invalid type for %s", id);
				return -EINVAL;
			}
			snd_config_get_string(n, &addr);
			str2ba(addr, &dst);
			continue;
		}

		if (strcmp(id, "src") == 0) {
			if (snd_config_get_type(n) != SND_CONFIG_TYPE_STRING) {
				SNDERR("Invalid type for %s", id);
				return -EINVAL;
			}
			snd_config_get_string(n, &addr);
			str2ba(addr, &src);
			continue;
		}

		SNDERR("Unknown field %s", id);
		return -EINVAL;
	}

	err = snd_pcm_a2dp_open(pcmp, name, &src, &dst, stream, mode);

	return err;
}

SND_DLSYM_BUILD_VERSION(_snd_pcm_a2dp_open, SND_PCM_DLSYM_VERSION);

--=-K59go3RISiZe+2dgS5LZ--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

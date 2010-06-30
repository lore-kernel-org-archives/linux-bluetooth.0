Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Jun 2010 10:53:48 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Lennart Poettering <lennart@poettering.net>
Subject: Re: SBC encoder/decoder API & errors handling
Message-ID: <20100630075348.GA23471@jh-x301>
References: <201006291845.53998.siarhei.siamashka@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
In-Reply-To: <201006291845.53998.siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Siarhei,

On Tue, Jun 29, 2010, Siarhei Siamashka wrote:
> When I tried to run some SBC encoder tests a few days ago, I noticed that 
> there is a regression introduced by commit:
> http://git.kernel.org/?p=bluetooth/bluez.git;a=commit;h=c43f8bdcc1d527e2d77481a66217771038be3acd
> 
> It is caused by the change from 'int' to 'size_t' for the type of variable 
> 'encoded' in 'sbcenc.c'. After this modification, the check for 'encoded <= 0' 
> does not catch the case when 'sbc_encode' tries to return a negative number in 
> 'encoded' variable. Later we end up calling 'write' function with a negative 
> size for the data block.
> 
> Right now, in the case of error 'sbc_encode' function may either return a 
> negative number as a return value, or return a negative value in 'encoded' 
> variable. But this second type of error is apparently not handled by anything 
> other than 'sbcenc' tool at the moment.
> 
> Any opinions about how to fix it in the best way? Because it is a flaw in the 
> library API, comments from the interested parties are welcome.

In general the API feels a bit weird in that it can return errors in two
different ways. A less obtrusive fix would be to make the variable type
ssize_t instead of size_t. Regarding breaking the SBC library API, I
don't see any big issue with that since it's internal to bluetoothd and
we can easily update the pulseaudio copy accordingly. Would the attached
patch make sense?

Johan

--y0ulUmNC+osPPQO6
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="sbc.patch"

diff --git a/audio/pcm_bluetooth.c b/audio/pcm_bluetooth.c
index cddeda2..4c0ab6f 100644
--- a/audio/pcm_bluetooth.c
+++ b/audio/pcm_bluetooth.c
@@ -1007,7 +1007,7 @@ static snd_pcm_sframes_t bluetooth_a2dp_write(snd_pcm_ioplug_t *io,
 	snd_pcm_sframes_t ret = 0;
 	unsigned int bytes_left;
 	int frame_size, encoded;
-	size_t written;
+	ssize_t written;
 	uint8_t *buff;
 
 	DBG("areas->step=%u areas->first=%u offset=%lu size=%lu",
diff --git a/sbc/sbc.c b/sbc/sbc.c
index 569dd7c..fa542e3 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -743,7 +743,7 @@ static int sbc_analyze_audio(struct sbc_encoder_state *state,
  * -99 not implemented
  */
 
-static SBC_ALWAYS_INLINE int sbc_pack_frame_internal(uint8_t *data,
+static SBC_ALWAYS_INLINE ssize_t sbc_pack_frame_internal(uint8_t *data,
 					struct sbc_frame *frame, size_t len,
 					int frame_subbands, int frame_channels,
 					int joint)
@@ -860,7 +860,7 @@ static SBC_ALWAYS_INLINE int sbc_pack_frame_internal(uint8_t *data,
 	return data_ptr - data;
 }
 
-static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len,
+static ssize_t sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len,
 								int joint)
 {
 	if (frame->subbands == 4) {
@@ -1005,10 +1005,10 @@ ssize_t sbc_decode(sbc_t *sbc, const void *input, size_t input_len,
 }
 
 ssize_t sbc_encode(sbc_t *sbc, const void *input, size_t input_len,
-			void *output, size_t output_len, size_t *written)
+			void *output, size_t output_len, ssize_t *written)
 {
 	struct sbc_priv *priv;
-	int framelen, samples;
+	ssize_t framelen, samples;
 	int (*sbc_enc_process_input)(int position,
 			const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
 			int nsamples, int nchannels);
diff --git a/sbc/sbc.h b/sbc/sbc.h
index 91422a9..2f830ad 100644
--- a/sbc/sbc.h
+++ b/sbc/sbc.h
@@ -92,7 +92,7 @@ ssize_t sbc_decode(sbc_t *sbc, const void *input, size_t input_len,
 
 /* Encodes ONE input block into ONE output block */
 ssize_t sbc_encode(sbc_t *sbc, const void *input, size_t input_len,
-			void *output, size_t output_len, size_t *written);
+			void *output, size_t output_len, ssize_t *written);
 
 /* Returns the output block size in bytes */
 size_t sbc_get_frame_length(sbc_t *sbc);
diff --git a/sbc/sbcenc.c b/sbc/sbcenc.c
index b5e0541..3d3a7dc 100644
--- a/sbc/sbcenc.c
+++ b/sbc/sbcenc.c
@@ -50,7 +50,7 @@ static void encode(char *filename, int subbands, int bitpool, int joint,
 	struct au_header au_hdr;
 	sbc_t sbc;
 	int fd, size, srate, codesize, nframes;
-	size_t encoded;
+	ssize_t encoded;
 	ssize_t len;
 
 	if (sizeof(au_hdr) != 24) {

--y0ulUmNC+osPPQO6--

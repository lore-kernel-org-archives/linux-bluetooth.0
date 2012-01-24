Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 24 Jan 2012 14:57:53 +0100
Message-ID: <CA+i+Aw0fW8qM8SrwM+rszgF-CB6NKG0wk-sqyOR+1_d4O37DLw@mail.gmail.com>
Subject: bluez static analysis: lib/sdp.c:sdp_gen_pdu()
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In file lib/sdp.c, at line 809 function sdp_gen_pdu() is defined as
follows (omitted parts not related to buf):

int sdp_gen_pdu(sdp_buf_t *buf, sdp_data_t *d)
{
[...]
### buf is directly dereferenced
	uint8_t *seqp = buf->data + buf->data_size;
[...]

	if (!is_seq && !is_alt) {
### buf is checked for NULL here
		if (src && buf && buf->buf_size >= buf->data_size + data_size) {
			memcpy(buf->data + buf->data_size, src, data_size);
			buf->data_size += data_size;
		} else if (dtd != SDP_DATA_NIL) {
			SDPDBG("Gen PDU : Can't copy from invalid source or dest\n");
		}
	}

	pdu_size += data_size;

	return pdu_size;
}

So the question is whether we are missing buf != NULL check at top, or
is the one present unnecessary?

-- 
Slawomir Bochenski

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 20 May 2013 11:36:30 -0600
Message-ID: <CAEhrai1s7Y0JHvd09k8y_xANE8EeLct-f_Z1FXWifRHF00kEew@mail.gmail.com>
Subject: Does sdp_seq_alloc_with_length() invoke undefined behavior?
From: Michael Bradshaw <mjbshaw@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After reading some sample HID client code[1] that brought up the
suspicious code in sdp_seq_alloc_with_length(), I'm wondering if it
possibly invokes undefined behavior.

I'll annotate the function:
sdp_data_t *sdp_seq_alloc_with_length(void **dtds, void **values, int *length,
                                      int len)
{
    sdp_data_t *curr = NULL, *seq = NULL;
    int i;

    for (i = 0; i < len; i++) {
        // ... removed to be concise ...
    }

    return sdp_data_alloc_with_length(SDP_SEQ8, seq, length[i]);
}

That last line looks like it is accessing one-past-the-end of the
length array when it says length[i]. Should the code execute that
line, i == len, and if len represents the number of elements in the
length array (which I think it does, but correct me if it does not),
then it does indeed invoke undefined behavior.

I'm hoping I could get some input from bluez developers who can say
with confidence whether or not this is a bug (so I know whether or not
I should open a bug report).

Thanks,

Michael

[1]: http://anselm.hoffmeister.be/computer/hidclient/index.html.en

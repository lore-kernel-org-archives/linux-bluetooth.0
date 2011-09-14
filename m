Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <73958080.14803.1315928807132.JavaMail.open-xchange@oxusltgw08.schlund.de>
References: <1315845241-17077-1-git-send-email-luiz.dentz@gmail.com>
	<1315845241-17077-4-git-send-email-luiz.dentz@gmail.com>
	<73958080.14803.1315928807132.JavaMail.open-xchange@oxusltgw08.schlund.de>
Date: Wed, 14 Sep 2011 12:12:45 +0300
Message-ID: <CABBYNZ+PF8MTreSzv_J4_43ukhU6m0fZD_2aOjGMdRwpM2DCNw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/5 v2] AVRCP: split AVCTP specific code from control.c
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "dstockwell@frequency-one.com" <dstockwell@frequency-one.com>
Cc: linux-bluetooth@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Tue, Sep 13, 2011 at 6:46 PM, dstockwell@frequency-one.com
<dstockwell@frequency-one.com> wrote:
> However, I am concerned that you have also moved the basic AVRCP messages --
> UNITINFO, SUBUNITINFO, and PASSTHROUGH --

Except they are not AVRCP at all, they are AV/C and AV/C panel as you
can see in e.g Table 3.2: Application Layer Feature to Procedure
Mapping. Now I could have created and avc.c to handle that but I felt
that was too much to begin with. As for PASSTHROUGH only those define
in Table 4.6: AVRCP Specific Vendor Unique PASS THROUGH command are
AVRCP specific, they part of 1.4, but for that we don't need to pass
the whole PDU.

> down into the AVCTP layer, which sort of messes things up again, IMO.

Hmm, so mixing AV/C with AVRCP is better than mixing with AV/C with
AVCTP? I don't think so, there are clearly 2 level of function
selection, first level defined by AV/C opcode (e.g.  UNITINFO,
SUBUNITINFO, PASSTHROUGH and VENDOR DEPENDENT) and the second by AVRCP
pdu id.

>> +static size_t handle_subunit_info(struct avctp *session,
>> +                                        uint8_t transaction, uint8_t
>> *code,
>> +                                        uint8_t *subunit, uint8_t
>> *operands,
>> +                                        size_t operand_count, void
>> *user_data)
>> +{
>> +        if (*code != AVC_CTYPE_STATUS) {
>> +                *code = AVC_CTYPE_REJECTED;
>> +                return 0;
>> +        }
>> +
>> +        *code = AVC_CTYPE_STABLE;
>> +
>> +        /* The first operand should be 0x07 for the UNITINFO response.
>> +         * Neither AVRCP (section 22.1, page 117) nor AVC Digital
>> +         * Interface Command Set (section 9.2.1, page 45) specs
>> +         * explain this value but both use it */
>> +        if (operand_count >= 2)
>> +                operands[1] = AVC_SUBUNIT_PANEL << 3;
>> +
>> +        DBG("reply to AVC_OP_SUBUNITINFO");
>> +
>> +        return 0;
>> +}
>> +
>
>
>
> IMO, this avctp_pdu_handler belongs at the AVRCP layer, not in AVCTP.

Well those headers are not defined on AVRCP either, are they?

>> +static void avctp_set_state(struct avctp *session, avctp_state_t
>> new_state)
>> +{
>> +        GSList *l;
>> +        struct audio_device *dev;
>> +        avctp_state_t old_state = session->state;
>> +
>> +        dev = manager_get_device(&session->server->src, &session->dst,
>> FALSE);
>> +        if (dev == NULL) {
>> +                error("avdtp_set_state(): no matching audio device");
>> +                return;
>> +        }
>> +
>> +        session->state = new_state;
>> +
>> +        for (l = callbacks; l != NULL; l = l->next) {
>> +                struct avctp_state_callback *cb = l->data;
>> +                cb->cb(dev, old_state, new_state, cb->user_data);
>> +        }
>> +
>> +        switch (new_state) {
>> +        case AVCTP_STATE_DISCONNECTED:
>> +                DBG("AVCTP Disconnected");
>> +
>> +                avctp_disconnected(session);
>> +
>> +                if (old_state != AVCTP_STATE_CONNECTED)
>> +                        break;
>> +
>> +                if (!audio_device_is_active(dev, NULL))
>> +                        audio_device_set_authorized(dev, FALSE);
>> +
>> +                break;
>> +        case AVCTP_STATE_CONNECTING:
>> +                DBG("AVCTP Connecting");
>> +                break;
>> +        case AVCTP_STATE_CONNECTED:
>> +                DBG("AVCTP Connected");
>> +                break;
>> +        default:
>> +                error("Invalid AVCTP state %d", new_state);
>> +                return;
>> +        }
>> +}
>> +
>
>
>
> In 1.3, passing AVC packets limited to 512 bytes, AVCTP-level fragmentation
> will be rare (how often does MTU drop below 672 bytes?).

Not sure how this has anything to do with the quoted code, but note
that doing this type of checks is easier with AVCTP and AV/C in the
same file.

>
>
> However, in 1.4 with browsing, we will need to add AVCTP-packet reassembly
> for mass metadata received from the TG.  This must not be confused with the
> AVRCP-layer Request Continuing calls, which are used to reassemble metadata
> sent on the control channel (Get Element Attributes) that exceeds the AVC
> max length.

Yep, but it is nothing it that can't be handled since the operands
size is given to AVRCP layer.


-- 
Luiz Augusto von Dentz

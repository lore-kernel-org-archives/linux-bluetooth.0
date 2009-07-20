Return-Path: <cyrus@holtmann.org>
From: "josem@robleshermoso.com" <josem@robleshermoso.com>
To: <linux-bluetooth@vger.kernel.org>
Subject: sdp update record
Date: Mon, 20 Jul 2009 01:46:58 -0700
Reply-To: josem@robleshermoso.com
Message-ID: <6256373e$7df40b29$569f21c8$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everyone 

Working with BlueZ 4.46, bluetoothd process makes an segfault when an 
"update sdp record" request is processed. Running with valgrind memcheck 
I checked that when an "search attr" request arrives after the "update sdp 
record",
 this record handle not exists because this memory has been freed in the 
"update sdp record" stage. The code block when "update spd record" is made 

is below: 


int service_update_req(sdp_req_t *req, sdp_buf_t *rsp)
{
        sdp_record_t *orec;
        int status = 0, scanned = 0;
        uint8_t *p = req->buf + sizeof(sdp_pdu_hdr_t);
        int bufsize = req->len - sizeof(sdp_pdu_hdr_t);
        uint32_t handle = ntohl(bt_get_unaligned((uint32_t *) p));

        SDPDBG("Svc Rec Handle: 0x%x", handle);

        p += sizeof(uint32_t);
        bufsize -= sizeof(uint32_t);

        orec = sdp_record_find(handle);

        SDPDBG("SvcRecOld: %p", orec);

        if (orec) {
                sdp_record_t *nrec = extract_pdu_server(BDADDR_ANY, p, 
bufsize,
                                                        handle, &scanned);
                if (nrec && handle == nrec->handle) {
                        update_db_timestamp();
                        update_svclass_list(BDADDR_ANY);
                } else {
                        SDPDBG("SvcRecHandle : 0x%x", handle);
                        SDPDBG("SvcRecHandleNew : 0x%x", nrec->handle);
                        SDPDBG("SvcRecNew : %p", nrec);
                        SDPDBG("SvcRecOld : %p", orec);
                        SDPDBG("Failure to update, restore old value");

                        status = SDP_INVALID_SYNTAX;
                }

                if (nrec)
                        sdp_record_free(nrec);
        } else
                status = SDP_INVALID_RECORD_HANDLE;

        p = rsp->data;
        bt_put_unaligned(htons(status), (uint16_t *) p);
        rsp->data_size = sizeof(uint16_t);
        return status;
}

If I comment the "sdp_record_free(nrec)" line, no segfault occurs.
If "extract_pdu_server" works like I think, first find the record, later 
delete all attrs and add the new attrs.
So that, sdp_record_free(nrec) is freeing the updated record, no?

I'm not in list, pleases cc'me.

Thanks and regards





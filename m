Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CD932937A
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 07:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781162638; cv=pass; b=Fqd1Lxrw7K7omRpfGpUVYEa1KzscFpEvSErBppX1e5GvgjVPScvkBh11JaVKhMxXeEJO5v5GA5nAzk2VS2MQQ9r3nyClcnIys6MFXkJDR7QomdeiuHko+vMn67c8x2xUGH+pKQ18YvcK8V0Xe9Uq5KxhXpy+GErUaravU/mQAEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781162638; c=relaxed/simple;
	bh=euHtg3kmLYFccJG1FlDqYEdWnmLK20sDsdYXLtkCIak=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=MO+fg0NbbJ6f9FgCy2FyPwb6URcEY9/j6CNzRl1+kCpHFNdZqrkG9JQ4W7ZD28H7WwlmqkL7FKdV65pOuaRASZChx3itHOndLbM3lQZzQI8SNfKP2f5bVM8yAc6zELGcsXPqhFx7vg714o8QfEnsoikamCsoUijrIAxgZ5aqDaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Taqsn2k3; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Taqsn2k3"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aa68dbb38aso7442137e87.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 00:23:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781162635; cv=none;
        d=google.com; s=arc-20240605;
        b=TTt4yvVa0KhV5w50LZZea7pD5BGU7ZHrPCdWuFeyEbC2QSP5Rhr25gjAOQW8OLMLGL
         tpmaJerPN7Ht/FmYmdAn00FP57W9Rn1OOhShqxVfXxcAEbkQLjbQsYZ2ivJn+Y73wSqm
         5PECTPgPgLojtu2gF0GfCZL9LSHFyaYzYG7HxsduNm3uVQhyJTyx3bVNeseb52SLPjVW
         9RbAa4C5vRBc/oab13LLTcGr9rSWTWdRJNGbAYj9YKXe0UvfigbYRocwMJyC2p3unYiD
         N/hfSjEf7VoCqLUYqzwNFhz0ahSrMKehRWRBS+8M/Pgf+db74kMrMbHn6AgVXsHtlguI
         pAlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=2FolJ3+CT8mQyGXI/4aNDnr5rUXBI08pNfHsJ3xVTN8=;
        fh=4lGQI6056MBa4/oovMyIYaKLn+Wz/24RGvUivMmQP8E=;
        b=dMYr+ovf5xrObAU8Qa+m79LlxMIB9UlnhBOFk2/PbRvmjyUrU+W37AtQvA/Sy9avQT
         GZYsV8XnhBAces6NOn5gthj4htocZ0ED1wrNppy0LpVE33AtVteX6k8roLnd1XCtl+y+
         qEerAQhzyqVK0OwbhYfmYeiuOF13QyAZZhVAqLPcHyjwmQLXefjXUjbSqpUyinw26rZ6
         FPUvv8hyttvHKISmy5gz0cCGNeiz/RDz2VVJjsDAFKtGv3v3U9p8fkXAL9vtCRet2NF/
         FUebF7E9LfJjUAoIsZF+8X6erH/U83G6herGOCzIJYgY1JaD5rcxG9giBBSva7gi8cFN
         ZvQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781162635; x=1781767435; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2FolJ3+CT8mQyGXI/4aNDnr5rUXBI08pNfHsJ3xVTN8=;
        b=Taqsn2k3ZoXyHRxeD+AX8iDpbOywHDpzBkD5ldolG4OL/DpydXSjqRYwhAXUEcA9Gt
         WEdTFT60igEmHPmoSZSd5T7Dobd7NZWCj3p2fZ/AUYSWTfho3EMSmxehakaKC0g2pPKc
         T+Ptc96pB+iQk4AC2QpIEoTHw52f+yu2N6vFmFyJeYqvOCaONou6N/GvzWXX6GaNGuu1
         BSvi9ctLerkX+GCemyRZJSskAryh55+OvpIFQlg/x+YKqunF/0A6wRXYeiVmauLiHoMd
         Au9aZRzSUukdunYi2Zg1GDfjejFtS+/JriNj4AxgCUZueEQPXofd/7eOAwNM05ZelJfB
         GW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781162635; x=1781767435;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2FolJ3+CT8mQyGXI/4aNDnr5rUXBI08pNfHsJ3xVTN8=;
        b=VQ/QgdTcSdf0hcepkKgM0nVLLr5y8JqDfJBFVH9zHOFx+8tBEBg4PNch0M0YHe4BG9
         8BOq0DAWi1atOhKFkADXns/NeIE9qIab92O0AwfQE7WgDqk+jkBCkME7t8DHSfVNC+MJ
         Di4EiD0SphZsiaO9pdZxhkkdnia5xwDBQ/KC5oM3WlywqSP8J/xN/ld4CuJAR78EIrAL
         pfgCu6TyhSNmp0m/duoNe9AzRWFNdIrEgXAz4Aglv8DeB64m4zotkheiQtQoUiMAKa/g
         E1GFPMYaxn3y+H328R2FSm8TOzBQ1ksthfcpMbQMrqsBlzDqKwUcy/UEHbqA3zBKe0DU
         oChQ==
X-Gm-Message-State: AOJu0YwoX2nk3t/7gCyyQCULDCYXOzikqab3eNBJDY9ZiRVvEPqunJq9
	aGqF8eUn2FWCzNaFk5xbosWpOb0CyELmn/6SANXBFyrNTbM+0o/oMUBWjIUTFjTa9JhFY2dB14k
	ca4kwbdCtFYnzhdwXG9gk7TAjAUToC5exn5yP
X-Gm-Gg: Acq92OGUCv1UzE69hswxNM9g/NPSEX7ZHUG8NKH99g6MIe7nQOiw2WfdY/3yloIWUWE
	W3VhgydhdpWn6KHZmo/k98ptWC+/IFWAcUXzRJYeK2p8fPJT7vwTkejHbHiObEhQOnyAgTohyCt
	a/uf2rYKABKPFMoNPtnOTuB16wGoO4IeZgVHqS87KZqGpoFbzaPwq7R+s3dUMa5v3v+8U3e4XaD
	103fX75HmulbRqhT06WTDBRNz5EvUTjy7qmtPJ+LhaEXOd1YG251vhcT+TfX5AYMBLImJmXvP7Z
	9C+16/P1bonN9HKRgQ==
X-Received: by 2002:a05:6512:31d0:b0:5aa:6e87:f22c with SMTP id
 2adb3069b0e04-5ad27ab1a42mr431982e87.12.1781162634584; Thu, 11 Jun 2026
 00:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "J.L." <ihipop@gmail.com>
Date: Thu, 11 Jun 2026 15:23:42 +0800
X-Gm-Features: AVVi8Cc5Aq5pDC7EVpSUMgQSmC1rzg6e8vKG9EDaICacWtUxot_IuAJCrVckXsE
Message-ID: <CAAO-DPssqW4tSbk=iiYBZyx7WxNqsMEZh0Oo4pNjY1333daDtA@mail.gmail.com>
Subject: [obexd/map] PushMessage does not expose outgoing MAP handle, causing
 MNS status events to be dropped
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

While debugging the BlueZ obexd MAP SMS sending flow, I found a race
condition in the outgoing message path.

When an application sends an SMS through
org.bluez.obex.MessageAccess1.PushMessage(), it only receives a
Transfer1 object. It does not receive the MAP message handle assigned
by the remote MSE. If the phone later reports SendingSuccess /
MessageShift / DeliverySuccess through MNS before obexd has created a
Message1 object for that handle, these events are silently ignored.

As a result, a D-Bus client cannot reliably associate a PushMessage
transfer with the resulting MAP message handle or sent/delivery
status.

Test environment:

- OS: Manjaro Linux rolling
- Kernel: Linux 6.12.91-1-MANJARO x86_64
- BlueZ source baseline: 5.86
- BlueZ source commit: 74770b1fd2be612f9c2cf807db81fcdcc35e6560
- Commit subject: Release 5.86

Problem description:

1. The client calls MessageAccess1.PushMessage().
2. The returned Transfer1 object becomes complete. The message is
accepted by the phone and the phone starts sending it.
3. The phone reports an MNS event such as:

    <event type="SendingSuccess"
           handle="0400000000008A1C"
           folder="telecom/msg/sent"
           msg_type="SMS_GSM" />

   It may also report MessageShift or DeliverySuccess.
4. However, if obexd has not yet created a Message1 object for this
handle in `map->messages`, SendingSuccess / MessageShift will just
return. No Message1 object is created, and no state change is exposed
to the D-Bus client.
5. The client is left with an unreliable workaround: after PushMessage
completes, immediately call ListMessages("outbox") or
ListMessages("sent") and hope that obexd materializes a Message1
object from the listing result. This is not atomic and still races
with status/folder transitions on the phone side.

Source analysis:

1. The D-Bus API documentation says PushMessage only returns a
Transfer1 object, not the MAP message handle

    doc/org.bluez.obex.MessageAccess.rst:179-195

    PushMessage(string sourcefile, string folder, dict args) transfers
a bMessage.
    The returned object path represents the newly created transfer and
is used to check transfer success/failure.
    The documentation does not expose a MAP message handle or define a
way to associate the transfer with a message handle.

2. map.c implements PushMessage as a PUT transfer, with a NULL queue callback

    obexd/client/map.c:1829-1851

    In push_message():

        transfer = obc_transfer_put("x-bt/message", folder, filename,
NULL, 0, &err);
        obc_transfer_set_apparam(transfer, apparam);

        if (!obc_session_queue(map->session, transfer, NULL, NULL, &err))
            goto fail;

        return obc_transfer_create_dbus_reply(transfer, message);

    There is no MAP-level completion callback here, so there is no
chance to bind the PushMessage result to a MAP handle in
`map->messages`.

    map_push_message() only parses the D-Bus arguments and then calls
push_message():

    obexd/client/map.c:1944-1980

3. The transfer completion path only updates Transfer1 status;
PushMessage currently has no callback

    obexd/client/transfer.c:657-685

    xfer_complete() sets the Transfer1 status to complete/error and
invokes the callback only if one exists.

    Since PushMessage queues the transfer with a NULL callback, the
MAP layer is not notified that the PUT completed in a way that would
allow it to parse or preserve the resulting MAP handle.

4. The gobex PUT response path does not expose final response
AppParams to the MAP layer

    gobex/gobex-transfer.c:181-220

    transfer_response() handles GET response bodies, but for PUT it
calls transfer_complete() directly on success. If the remote MSE
returns a message handle or related AppParams in the PUT response,
that information is not currently exposed to obexd/client/map.c.

5. ListMessages lazily creates Message1 objects

    obexd/client/map.c:1274-1325

    In msg_element(), while parsing a message listing:

        handle = strtoull(values[i], NULL, 16);

        msg = g_hash_table_lookup(data->messages, &handle);
        if (msg == NULL) {
            msg = map_msg_create(data, handle, parser->request->folder, NULL);
            ...
        }

    map_msg_create() registers org.bluez.obex.Message1 and inserts it
into `data->messages`:

    obexd/client/map.c:959-985

    This means Message1 creation depends on either a NewMessage event
or a ListMessages result. PushMessage itself does not create the
corresponding Message1.

6. MNS parsing does recognize SendingSuccess / DeliverySuccess /
MessageShift and their handle

    obexd/client/map-event.h:13-35
    obexd/client/mns.c:151-177

    mns.c parses SendingSuccess / DeliverySuccess / MessageShift into
map_event and parses the handle.

7. However, status/folder MNS events require an existing Message1
object, otherwise they are silently dropped

    obexd/client/map.c:2075-2093

    map_handle_status_changed():

        msg = g_hash_table_lookup(map->messages, &event->handle);
        if (msg == NULL)
            return;

    obexd/client/map.c:2095-2116

    map_handle_folder_changed():

        msg = g_hash_table_lookup(map->messages, &event->handle);
        if (!msg)
            return;

    obexd/client/map.c:2118-2150

    map_handle_notification() dispatches SendingSuccess /
DeliverySuccess / MessageShift to these status/folder handlers.
Therefore, if Message1 has not yet been created by NewMessage or
ListMessages, these events are silently ignored.

Race conditions:

1. There is a gap between PushMessage completion and Message1 creation

    PushMessage completion only tells the application that the
bMessage has been PUT to the remote MSE.
    obexd does not create a Message1 at that point and does not expose
the remote handle to the D-Bus client.

2. MNS events may arrive before the client can run the ListMessages workaround

    The phone may send SendingSuccess / MessageShift shortly after the
PUT completes.
    If the client has not yet called ListMessages("outbox") or
ListMessages("sent"), obexd has no matching handle in `map->messages`,
so the event is dropped.

3. The ListMessages workaround is not reliable

    A client can call ListMessages("outbox") after PushMessage
completes, causing obexd to create Message1 objects from the listing
result.
    However, the message may already have moved from outbox to sent,
or the phone-side state may already have changed, so outbox listing
may miss it.
    Listing sent instead still does not provide an atomic ordering
guarantee with respect to MNS events.
    There is no way for an application to atomically obtain the handle
immediately after PushMessage completion.

Expected behavior:

After PushMessage succeeds, obexd should provide a reliable way for
the D-Bus client to obtain the MAP message handle, or at least ensure
that subsequent MNS status/folder events for that handle are not
dropped just because Message1 has not yet been materialized.

Possible fixes:

1. Create or cache an outgoing message entry when PushMessage completes

    If the MAP PUT response provides a message handle, obexd could
create or cache
    a handle-indexed outgoing message entry in the PushMessage completion path.

    This entry could be exported immediately as org.bluez.obex.Message1, or, if
    exposing a partially populated D-Bus object is not desirable, it could first
    be kept as an internal-only entry. The important part is that subsequent MNS
    events such as SendingSuccess / MessageShift / DeliverySuccess can find the
    handle instead of returning early.

    With the current map_msg_create() implementation, creating Message1 also
    registers the D-Bus object and would make clients observe an
    org.freedesktop.DBus.ObjectManager.InterfacesAdded signal for
    org.bluez.obex.Message1. If maintainers prefer not to emit InterfacesAdded
    at this stage, a separate internal stub/cache path could be added, and the
    object could be exported later when enough message metadata is available.

2. Add a D-Bus API that exposes the real MAP message handle and allows
   handle-based access

    MAP itself already has a handle-based GetMessage operation. BlueZ also
    already uses this model internally: org.bluez.obex.Message1.Get() formats
    msg->handle and sends an OBEX GET request with type "x-bt/message":

        obexd/client/map.c:450-485

            snprintf(handle, sizeof(handle), "%" PRIx64, msg->handle);
            transfer = obc_transfer_get("x-bt/message", handle,
target_file, &err);

    However, the current D-Bus API only exposes Get() on an existing
    org.bluez.obex.Message1 object. There is no MessageAccess1 method such as
    GetMessageByHandle() or CreateMessageFromHandle(), and MessageAccess1 only
    exposes ListMessages() and PushMessage():

        obexd/client/map.c:1986-2008

    This means a client that already knows the real MAP handle still cannot use
    it unless obexd has first materialized a Message1 object through
    NewMessage or ListMessages.

    A possible API-level fix would be to preserve the MAP-specific response
    metadata on the Transfer1 object returned by PushMessage. For example, when
    the remote MSE returns a handle or other MAP application parameters for the
    pushed message, obexd could expose them as Transfer1 properties, at minimum
    with Handle  itself, With that, the client can atomically obtain
the real handle from the
    PushMessage transfer result, then query or materialize the corresponding
    message by handle. Today this is not possible because the handle is not
    preserved or exposed after PushMessage completes, so clients are forced to
    infer the message by racing ListMessages(folder) against remote status and
    folder changes.

Questions:

1. Is this an expected limitation of the current obexd MAP client, or
should this be considered a bug?
2. Which fix direction would be preferred: creating Message1 in the
PushMessage completion path, adding a D-Bus signal?
3. I can  provide a redacted btmon capture and the corresponding
MAP-event-report snippets to show the actual event ordering observed
on real devices if needed

Thanks.

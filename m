Return-Path: <SRS0=dtqE=NX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADDAC43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Nov 2018 12:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F6C22419
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Nov 2018 12:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOPDsem0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F6C22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbeKLWSA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Nov 2018 17:18:00 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43022 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeKLWSA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Nov 2018 17:18:00 -0500
Received: by mail-ot1-f67.google.com with SMTP id a11so4112438otr.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Nov 2018 04:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E05EshZYo7TdjeZSjYkHHvnb4GVDBjKy/zmxQMrZr9E=;
        b=hOPDsem0phptyqzs9fRtSGnQxw0/eLxzipQ4zAniJ1K5QZT+Lr/y9+f+pLau+Sklls
         5P9PBFPItlqI9S/sqzsv8YAWdhWHS3kgJuJVJj2H2++y7HAF7si5iTa1JsnYCjnGdP/3
         L6mmI1u3sUeD8NUreU4JMSd6VQ0d/SUQowLA3XhZEiVakbym187PAcna4VljN9jfCT5w
         nFDuHrY/nf33YYoA+ucFgBkenr1HU4yEStqyDCFpnL4j98SRNrm6LbVd1mpfIp4qNSpB
         QX8uTbZg4jM7KZkGe9N0D7p+dTBPn+DoPuQSyQ+Ee+vJuLwA9QM0VgvHxKiuOZFDf2yr
         kv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E05EshZYo7TdjeZSjYkHHvnb4GVDBjKy/zmxQMrZr9E=;
        b=DcwVmKur4iClfwVdSa6AvXyR1ohco6RYWVolNC7fkd01X+LF1iKeQrfuQqr/MkN0uS
         3F79L2NBFW5f4/ZpTwmMZedABVxxyxnGADlBRntT+8pxvPIkV0upQ+oTuWLAwT7nqYPz
         8nmGNnvjY5uRB/XTg4g5+KvRdrUAtd8UO12pMyYJFp5J2egDh875eL4XeCbkFrGbkii/
         508Cbd9ZkHHABGdD09tPYJbCDI2gSdJKmuKRxWQ/hUzRUDCSM42jz4W/7ZRtEMjNjyNF
         BD7Vcjv59XoxSzEyuZuBuGU8TtxMKkAVDXFEG9wHZv3IfVCRXxOeIT066+NpWBnxgDiG
         FxGw==
X-Gm-Message-State: AGRZ1gL5pQvRqWPlcmO0bzmFP5RhL5uF8orzMbrNBPgAYWljYABAR3vD
        RlxaVq9XjFxlV8K1E589FR1eyACnYii544Msp0o=
X-Google-Smtp-Source: AJdET5d5sSMGNyZFxg4sHC6uOsxZDPlgquGGuoe1noPmseRPsWE02VMnDfxEdOoG5XF4sqIHnWTVAP0JH/IPwb56xIM=
X-Received: by 2002:a9d:3d0:: with SMTP id f74mr406512otf.52.1542025495180;
 Mon, 12 Nov 2018 04:24:55 -0800 (PST)
MIME-Version: 1.0
References: <20181112013317.5714-1-inga.stotland@intel.com>
In-Reply-To: <20181112013317.5714-1-inga.stotland@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 12 Nov 2018 14:24:42 +0200
Message-ID: <CABBYNZJLLxNC3BQvyDxzTFLppe25ke=VK_9QtvJsNbCFjnUW2A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] doc: Initial Bluetooth Mesh API
To:     "Stotland, Inga" <inga.stotland@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "Gix, Brian" <brian.gix@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On Mon, Nov 12, 2018 at 3:35 AM Inga Stotland <inga.stotland@intel.com> wrote:
>
> This decribes proposed D-Bus based API for Bluetooth Mesh
> implementation.
> ---
>  doc/mesh-api.txt | 409 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 409 insertions(+)
>  create mode 100644 doc/mesh-api.txt
>
> diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
> new file mode 100644
> index 000000000..0a7f00ec2
> --- /dev/null
> +++ b/doc/mesh-api.txt
> @@ -0,0 +1,409 @@
> +BlueZ D-Bus Mesh API description
> +********************************
> +
> +Mesh Network Hierarchy
> +======================
> +Service                org.bluez.mesh
> +Interface      org.bluez.mesh.Network1
> +Object path    /org/bluez/mesh
> +
> +Methods:
> +               uint64 Join(object provision_agent,
> +                                                       array{string} capabilities,
> +                                                       array{byte}[16] uuid,
> +                                                       array{string} oob_info,
> +                                                       uint32 uri_hash,
> +                                                       array{byte} composition)

Except for the UUID I would assume that everything else could be made
into a property in the agent object, or is there any reason not to use
that? I don't see why not since for attach you expect the application
has implemented ObjectManager interface so this would mean on Join we
would already fetch all the objects.

> +                       This is the first method that an application has to call to become
> +                       a node on a mesh network.
> +
> +                       The provision_agent parameter is the object that implements
> +                       org.bluez.mesh.ProvisionAgent interface.
> +
> +                       The capabilities parameter is an array of strings with the following
> +                       allowed values:
> +                       "blink", "beep", "vibrate", "out-numeric", "out-alpha", "push",
> +                       "twist", "in-numeric", "in-alpha", "public-oob", "static-oob".
> +
> +                       The uuid parameter is a 16-byte array that contains Device UUID.
> +
> +                       The oob_info parameter is an array of strings with the following
> +                       allowed values:
> +                       "other", "uri", "machine-code-2d", "bar-code", "nfc", "number",
> +                       "string", "on-box", "in-box", "on-paper", "in-manual", "on-device"
> +                       The array can be empty if oob data is not available.
> +
> +                       The uri_hash parameter is a 4-octet value that contains URI Hash
> +                       data that is gnnerated as described in Mesh Profile. If no URI is,
> +                       available, the passed in value shall be zero.
> +
> +                       The composition parameter is a byte array whose layout
> +                       follows that of the composition data as defined by Mesh Profile
> +                       specification. The daemon implements Configuration Server model.
> +                       The composition data array may not include the Configuration Server
> +                       model id in which case the model id will be implicitly aded by the
> +                       daemon.
> +
> +                       In case of success, the method returns a 64-bit token. The token
> +                       must be preserved by the application in order to authenticate itself
> +                       to the mesh daemon and attach to the network as a mesh node or
> +                       permanently remove the identity of the mesh node.
> +
> +                       After the successful completion of this method, the application
> +                       should call Attach() method to obtain access to mesh network.
> +                       The meshd daemon retains persistent information about the node
> +                       identified by the token.
> +
> +                       PossibleErrors:
> +                               org.bluez.mesh.Error.Failed,
> +                               org.bluez.mesh.Error.Canceled,
> +                               org.bluez.mesh.Error.InvalidArguments
> +                               org.bluez.mesh.Error.Timeout
> +
> +               void Cancel(void)
> +                       Cancels an outstanding Join method. Join will return with
> +                       org.bluez.mesh.Error.Canceled
> +
> +               (object node, array{byte, array{(uint16, dict}} configuration)
> +                               Attach(object app_defined_root, uint64 token)
> +
> +                       After successful Provisioning/Joining (i.e., after the initial
> +                       successful Join call), this is the first method that an application
> +                       must call to obtain access to mesh node functionalities.
> +                       The daemon verifies whether the application is authorized to
> +                       use this mesh node based on the value of the 64-bit token, which has
> +                       been assigned to the application when it first joined mesh network.
> +
> +                       The app_defined_root parameter is a D-Bus object root path of the
> +                       node where child mesh elements have their own objects that implement
> +                       the org.bluez.mesh.Access interface. The standard DBus.ObjectManager
> +                       interface must be available on the app_defined_root path. The
> +                       app_defined_root tree must conform to the naming convention
> +                       described in the Mesh Application Hierarchy.

This could have been given at Join already, the daemon could recognize
that and auto-attach after joining which means Attach only be needed
when reattaching e.g. after reboot, or perhaps to read out the
configuration but that could already been made at Join so it doesn't
incur in any traffic.

> +                       The token parameter is a 64-bit number that has been obtained
> +                       as a result of successful Join() method call.
> +
> +                       In case of success, the method call returns mesh node object (see
> +                       Mesh Node Hierarchy section) and current configuration settings.
> +                       The configuration parameter is an array, where each entry is a
> +                       configuration per node element:
> +                               index (byte) - element index
> +                               array of model configurations:
> +                                       model_id (uint16) - SIG Model Identifier
> +                                       model_config - dictionary with the following keys defined:
> +
> +                                               array{uint16} Bindings : Indices of application keys
> +                                                                       bound to the model
> +                                               uint32 PublicationPeriod : Model publication period in
> +                                                                       milliseconds
> +                                               uint16 Vendor: a 16-bit Bluetooth-assigned Company
> +                                                                       Identifier of the vendor as defined by
> +                                                                       Bluetooth SIG
> +
> +                       PossibleErrors:
> +                               org.bluez.mesh.Error.InvalidArguments
> +                               org.bluez.mesh.Error.NotFound,
> +                               org.bluez.mesh.Error.Failed
> +
> +               void Leave(uint64 token)
> +
> +                       This removes the configuration information about the mesh node
> +                       identified by the 64-bit token parameter. The token parameter
> +                       has been obtained as a result of successful Join() method call.
> +
> +                       PossibleErrors:
> +                               org.bluez.mesh.Error.NotFound
> +
> +Mesh Node Hierarchy
> +===================
> +Service                org.bluez.mesh
> +Interface      org.bluez.mesh.Node1
> +Object path    /org/bluez/mesh/node<xxxx>
> +               where xxxx is a 4-digit hexadecimal number generated by meshd daemon
> +
> +Methods:
> +
> +               void Send(object element_path, uint16 destination, uint16 key_index,
> +                                                               array{byte} data)

It seems wrong  to me to have to send your own object as method
argument, usually this sort of communication goes as a Signal but it
seems the Element interface has no signal to be able to do something
like that.

> +                       This method is used to send a message originated by a local model.
> +
> +                       The element_path parameter is the object path of an element from
> +                       a collection of the application elements (see Mesh Application
> +                       Hierarchy section).
> +
> +                       The destination parameter contains the destination address. This
> +                       destination must be a uint16 to a unicast address, or a well known
> +                       group address.
> +
> +                       The key_index parameter determines which application key to use for
> +                       encrypting the message. The key_index must be valid for that
> +                       element, i.e., the application key must be bound to a model on this
> +                       element. Otherwise, org.bluez.mesh.Error.NotAuthorized will be
> +                       returned.
> +
> +                       The data parameter is an outgoing message to be encypted by the
> +                       meshd daemon and sent on.
> +
> +                       Possible errors:
> +                               org.bluez.mesh.Error.NotAuthorized
> +                               org.bluez.mesh.Error.InvalidArguments
> +                               org.bluez.mesh.Error.NotFound
> +
> +               void Publish(object element_path, uint16 model, array{byte} data)

Ditto, this could easily be translated into a signal like
Publish(uint16 model, array{byte} data)

> +                       This method is used to send a publication originated by a local
> +                       model. If the model does not exist, or it has no publication record,
> +                       the method returns org.bluez.mesh.Error.DoesNotExist error.
> +
> +                       The element_path parameter is the object path of an element from
> +                       a collection of the application elements (see Mesh Application
> +                       Hierarchy section).
> +
> +                       The model parameter contains a model ID, as defined by the
> +                       Bluetooth SIG.
> +
> +                       Since only one Publish record may exist per element-model, the
> +                       destination and key_index are obtained from the Publication
> +                       record cached by the daemon.
> +
> +                       Possible errors:
> +                               org.bluez.mesh.Error.DoesNotExist
> +                               org.bluez.mesh.Error.InvalidArguments
> +                               org.bluez.mesh.Error.NotFound
> +
> +               void VendorPublish(object element_path, uint16 vendor, uint16 model_id,
> +                                                               array{byte} data)

Ditto, VendorPublish(uint16_t vendor, uint16 model, array{byte} data),
actually to be a bit more flexible and able to extend that could just
be Publish(dict config, array{byte} data) where a key inside the
config would tell what vendor it is (in case it is omitted there is no
vendor), etc.

> +                       This method is used to send a publication originated by a local
> +                       vendor model. If the model does not exist, or it has no publication
> +                       record, the method returns org.bluez.mesh.Error.DoesNotExist error.
> +
> +                       The element_path parameter is the object path of an element from
> +                       a collection of the application elements (see Mesh Application
> +                       Hierarchy section).
> +
> +                       The vendor parameter is a 16-bit Bluetooth-assigned Company
> +                       Identifier.
> +
> +                       The model_id parameter is a 16-bit vendor-assigned Model Identifier.
> +
> +                       Since only one Publish record may exist per element-model, the
> +                       destination and key_index are obtained from the Publication
> +                       record cached by the daemon.
> +
> +                       Possible errors:
> +                               org.bluez.mesh.Error.DoesNotExist
> +                               org.bluez.mesh.Error.InvalidArguments
> +                               org.bluez.mesh.Error.NotFound
> +
> +Properties:
> +               dict Features [read-only]
> +
> +                       The following keys are defined:
> +                                       uint16 Friend
> +                                       uint16 LowPower
> +                                       uint16 Proxy
> +                                       uint16 Beaconing
> +                       with following  enumerated values:
> +                                       0 - feature is disabled
> +                                       1 - feature is enabled
> +                                       2 - feature is unsupported

We normally don't use enumeration in the D-Bus API so it is
human-readable, instead what we could do here is the following:

Possible keys: "friend", "low-power", "proxy", "beacon"
Possible values: bool true (enabled), flase (disabled)

If a key doesn't appear on the dict that means it is not supported.

> +               uint32 SecondsSinceLastHeard [read-only]
> +                       This property may be read at any time to determine the number of
> +                       seconds since mesh network layer traffic was last detected on this
> +                       node's network.
> +
> +               uint16 unicast [read-only] : Primary unicast address assigned to
> +                       this node

The application should only need to know its own node information but
if we publish it as a property as above anyone could read it, though
they don't know in which network the node is it is still safer not
expose information that is bound to an application.

Another note on this, if every application is a different node and we
have to expose the node object this could potentially bloats the
number of objects of the daemon, so Id recommend that either we
rethink if this object is really necessary or we could perhaps do
everything with signals from the elements, or we just have one node
object which infer the real node information using the message sender
to resolve the application/node.

> +Mesh Application Hierarchy
> +==========================
> +Service                unique name
> +
> +An applcation is a collection of elements that host SIG defined and vendor
> +specific models. It is expected that an application implements
> +org.freedesktop.DBus.ObjectManager interface.
> +
> +An example mesh application hierarchy may look like this:
> +
> +               -> /com/example
> +                       |   - org.freedesktop.DBus.ObjectManager
> +                       |   - org.bluez.mesh.Attention1 (optional)
> +                       |
> +                       -> /com/example/ele00
> +                       | |   - org.bluez.mesh.Element1
> +                       -> /com/example/ele01
> +                       | |   - org.bluez.mesh.Element1
> +                       ...
> +                       -> /com/example/elexx
> +                       | |   - org.bluez.mesh.Element1
> +
> +Mesh Element Hierarchy
> +======================
> +Service                unique name
> +Interface      org.bluez.mesh.Element1
> +Object path    /<app_defined_root>/ele<yy>
> +               where yy is a 2-digit zero relative hexadecimal index of the element

Usually application object path are freely defined, if the index is
really needed (cannot give it a number based on the order they
appear?) then have it as a property.

> +Methods:
> +
> +               void MessageReceived(uint16 source, uint16 key_index, bool subscription,
> +                                                                       array{byte} data)
> +
> +                       This method is called by meshd daemon when a message arrives
> +                       addressed to the application.
> +
> +                       The source parameter is unicast address of the remote node-element
> +                       that sent the message.
> +
> +                       The key_index parameter indicates which application key has been
> +                       used to decode the incoming message. The same key_index should be
> +                       used by the application when sending a response to this message
> +                       (in case a response is expected).
> +
> +                       The subscription parameter is a boolean that is set to true if
> +                       the message is received as a part of the subscription (i.e., the
> +                       destination is either a well known group address or a virtual
> +                       label.
> +
> +                       The data parameter is the incoming message.
> +
> +               void UpdateModelConfiguration(uint16 model_id, dict config)
> +
> +                       This method is called by meshd daemon when a model's configuration
> +                       is updated.
> +
> +                       The model_id parameter contains BT SIG Model Identifier.
> +
> +                       The config parameter is a dictionary with the following keys
> +                       defined:
> +
> +                               array{uint16} Bindings : Indices of application keys
> +                                                                       bound to the model
> +                               uint32 PublicationPeriod : Model publication period in
> +                                                                       milliseconds
> +                               uint16 Vendor: a 16-bit Bluetooth-assigned Company
> +                                                                       Identifier of the vendor as defined by
> +                                                                       Bluetooth SIG

Im lost here, are the keys strings here?

> +Mesh Attention Hierarchy
> +========================
> +Service                unique name
> +Interface      org.bluez.mesh.Attention1
> +Object path    freely definable
> +
> +This is an optional interface that implements health attention timer.
> +
> +Methods:
> +               void SetTimer(uint8 element_index,  uint16 time)
> +
> +                       The element_index parameter is the element's index within the node
> +                       where the health server model is hosted.
> +
> +                       The time parameter indicates how many seconds the attention state
> +                       shall be on.
> +
> +                       PossibleErrors:
> +                               org.bluez.mesh.Error.NotSupported
> +
> +               uint16 GetTimer(uint16 element)
> +
> +                       The element parameter is the unicast address within the node
> +                       where the health server model is hosted.
> +
> +                       Returns the number of seconds for how long the attention action
> +                       remains staying on.
> +
> +                       PossibleErrors:
> +                               org.bluez.mesh.Error.NotSupported
> +
> +
> +Provisioning Agent Hierarchy
> +============================
> +Service                unique name
> +Interface      org.bluez.mesh.ProvisionAgent
> +Object path    freely definable
> +
> +Methods:
> +               array{byte} PrivateKey()
> +
> +                       This method is called during provisioning if the Provisioner
> +                       has requested Out-Of-Band ECC key exchange. The Private key
> +                       is returned to the Daemon, and the Public Key is delivered to
> +                       the remote Provisioner using a method that does not involve
> +                       the Bluetooth Mesh system. The Private Key returned must be
> +                       32 octets in size, or the Provisioning procedure will fail
> +                       and be canceled.
> +
> +                       This function will only be called if the Provisioner has
> +                       requested pre-determined keys to be exchanged Out-of-Band,
> +                       and the local role is Unprovisioned device.
> +
> +               array{byte} PublicKey()
> +
> +                       This method is called during provisioning if the local device
> +                       is the Provisioner, and is requestng Out-Of-Band ECC key
> +                       exchange. The Public key is returned to the Daemon
> +                       that is the matched pair of the Private key of the remote
> +                       device. The Public Key returned must be 64 octets in
> +                       size, or the Provisioning procedure will fail and be canceled.
> +
> +                       This function will only be called if the Provisioner has
> +                       requested pre-determined keys to be exchanged Out-of-Band,
> +                       and the local role is Provisioner.
> +
> +               void DisplayString(string display)
> +                       This method is called when the Daemon has something important
> +                       for the Agent to Display, but does not require any additional
> +                       input locally. For instance: "Enter "ABCDE" on remote device".
> +
> +               void DisplayNumeric(uint8 type, uint32 number)
> +
> +                       This method is called when the Daemon has something important
> +                       for the Agent to Display, but does not require any additional
> +                       input locally. For instance: "Enter 149264 on remote device".
> +
> +                       The type parameter indicates the display method. An enumeration
> +                       of "Blink", "Beep", "Vibrate", or "OutNumeric".
> +
> +                       The number parameter is the specific value represented by
> +                       the Prompt.
> +
> +               uint32 PromptNumeric(uint8 type)
> +
> +                       This method is called when the Daemon has requires the user to
> +                       enter a 1-9 digit decimal value.
> +
> +                       The type parameter indicates the input method. An enumeration
> +                       of "Push", "Twist", or "InNumeric".
> +
> +                       This agent should prompt the user for specific input. For instance:
> +                       "Enter value being displayed by remote device".
> +
> +               array{byte} PromptStatic(uint8 type)
> +
> +                       This method is called when the Daemon requires a 16 octet
> +                       byte array, as an Out-of-Band authentication.
> +
> +                       The type parameter indicates the input method. An enumeration
> +                       of "Static", or "InAlpha".
> +
> +                       The Static data returned must be 16 octets in size, or the
> +                       Provisioning procedure will fail and be canceled. If input is
> +                       an InAlpha String, the printable charactors should be left
> +                       justified, with trailing 0x00 octets filling the remaining bytes.
> +
> +               void Cancel()
> +
> +                       This method gets called by the daemon to cancel any existing
> +                       Agent Requests. When called, any pending user input should be
> +                       canceled.
> +
> +
> +Mesh Provisioner Hierarchy
> +==========================
> +<TBD>
> --
> 2.17.2
>


-- 
Luiz Augusto von Dentz

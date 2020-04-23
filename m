Return-Path: <SRS0=6Duj=6H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1D2C54FCB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 16:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 598B920857
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 16:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/BrwfaZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbgDWQf5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729407AbgDWQf5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Apr 2020 12:35:57 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6128AC09B041
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 09:35:57 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id j26so7156654ots.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 09:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YMZrmu3F3bGnWR6CFo0kBS0KSTKHj9JtijwmeNEPcNw=;
        b=f/BrwfaZt8eTGE7jaqdHIq9VRU8eVXUvZ5kUNve7D2+1jYG6w3CyyQpAWvYsHl+ed8
         rgb7nX4LWfNXTiUWgCzirpI9CKrwngI5LDQGn4Ua3smlC5RMrQGHaNJQ3H1TAebVSaaq
         L3sXzAHsKSVOHlhuemswPA1k0MHlWwP6ddd4YhqdMi4tnraHx1bTn24V4/Q1a4+cJ8ee
         f4iMJMqU8z0R1gGLSJiFDdbwKBawz9Ihrd7vJpLF3QiMqaYLs6MuD9BnB0ike7WZJ7f3
         bZ4dtpN3/ak6IFZ+5Us9OtYhVL4Mbzheq8dpxvG3fTF3Y0GX2twIzstY2M/ZZEbRiD97
         yTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YMZrmu3F3bGnWR6CFo0kBS0KSTKHj9JtijwmeNEPcNw=;
        b=txm+FXgI4GGgBo6IcMc6vSFmZSC5mbti1QIDlKx8iEjhh3nGSxetTrpbWN3AGRWwel
         YvvODJTC2AdKZFZTTegCHwxJiLdoX0cbjlC93oG2rVoMm8JY70/7JbqIkUAD1YVYF6r8
         d4oUCysfXX3ur2kfZ+SwWSfK7GcmigdrWBpImNMhbE4fPHcpYzEAlFoLqKQHnZx89MwX
         4CDUhVtkizBrh33sXXO++8fChHnL5sQt6I+rQ0j/3Tsv6NjajlNibmJOf1Nah7AL2kGV
         J+DIp6p7/p+kSaGOrteuqLzgyxKbLzYU+iUO4vQPmeF1oaLv0UagQi9Nv/f9IC4AWjPe
         CUzQ==
X-Gm-Message-State: AGi0PuYMoEAADJgVzZT6olLDxBiqaczUD+ifkJUFwfuIbxf12sOP9dzf
        nhhxA49mLGRN42DrxFiKLwvIZkw8V1uExnMwlYPljd4k
X-Google-Smtp-Source: APiQypJSrgqgNzenAJ2Kgrezl2ObxsTv71VNyVjcgx5jtSn73DMtN+VXubLB7bRc6FWQL3KX8KyVO6JHpnwZ5I+HkkE=
X-Received: by 2002:a9d:644:: with SMTP id 62mr3671731otn.177.1587659756460;
 Thu, 23 Apr 2020 09:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200422160810.Bluez.1.I31f4f214084c9e6557e2d918540397e155b9faf0@changeid>
 <CABBYNZLYE8qw-FHwHVS30LYTWNGgh=YrgQGCUL8y86R6mhfQ9g@mail.gmail.com> <CANFp7mWJjnNkSi9Y9LK2N06mX_PZA5C_Qcj64q8A_qoJkZXTuw@mail.gmail.com>
In-Reply-To: <CANFp7mWJjnNkSi9Y9LK2N06mX_PZA5C_Qcj64q8A_qoJkZXTuw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 23 Apr 2020 09:35:44 -0700
Message-ID: <CABBYNZJ3U+fjETxPizmudRE_8kB9OUcfae9VKozdCOMxxeYUHg@mail.gmail.com>
Subject: Re: [Bluez PATCH] clang-format: Add .clang-format configuration
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

On Wed, Apr 22, 2020 at 5:22 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> Hi Luiz,
>
> On Wed, Apr 22, 2020 at 5:04 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Abhishek,
> >
> > On Wed, Apr 22, 2020 at 4:08 PM Abhishek Pandit-Subedi
> > <abhishekpandit@chromium.org> wrote:
> > >
> > > Add a clang-format configuration that follows the kernel style guide.
> > >
> > > This file was taken from the Linux kernel repository at
> > > commit 11a4a8f73b3ce71b32f36e9f1655f6ddf8f1732b
> >
> > Is this similar to check-patch?
>
> It's more for automatically formatting code. I use it with vim-codefmt
> to automatically format code blocks when I don't want to do it
> manually.

Got it.

> >
> > > ---
> > >
> > >  .clang-format | 521 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 521 insertions(+)
> > >  create mode 100644 .clang-format
> > >
> > > diff --git a/.clang-format b/.clang-format
> > > new file mode 100644
> > > index 000000000..6ec5558b5
> > > --- /dev/null
> > > +++ b/.clang-format
> > > @@ -0,0 +1,521 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +#
> > > +# clang-format configuration file. Intended for clang-format >= 4.
> > > +#
> > > +# For more information, see:
> > > +#
> > > +#   Documentation/process/clang-format.rst
> > > +#   https://clang.llvm.org/docs/ClangFormat.html
> > > +#   https://clang.llvm.org/docs/ClangFormatStyleOptions.html
> > > +#
> > > +---
> > > +AccessModifierOffset: -4
> > > +AlignAfterOpenBracket: Align
> > > +AlignConsecutiveAssignments: false
> > > +AlignConsecutiveDeclarations: false
> > > +#AlignEscapedNewlines: Left # Unknown to clang-format-4.0
> > > +AlignOperands: true
> > > +AlignTrailingComments: false
> > > +AllowAllParametersOfDeclarationOnNextLine: false
> > > +AllowShortBlocksOnASingleLine: false
> > > +AllowShortCaseLabelsOnASingleLine: false
> > > +AllowShortFunctionsOnASingleLine: None
> > > +AllowShortIfStatementsOnASingleLine: false
> > > +AllowShortLoopsOnASingleLine: false
> > > +AlwaysBreakAfterDefinitionReturnType: None
> > > +AlwaysBreakAfterReturnType: None
> > > +AlwaysBreakBeforeMultilineStrings: false
> > > +AlwaysBreakTemplateDeclarations: false
> > > +BinPackArguments: true
> > > +BinPackParameters: true
> > > +BraceWrapping:
> > > +  AfterClass: false
> > > +  AfterControlStatement: false
> > > +  AfterEnum: false
> > > +  AfterFunction: true
> > > +  AfterNamespace: true
> > > +  AfterObjCDeclaration: false
> > > +  AfterStruct: false
> > > +  AfterUnion: false
> > > +  #AfterExternBlock: false # Unknown to clang-format-5.0
> > > +  BeforeCatch: false
> > > +  BeforeElse: false
> > > +  IndentBraces: false
> > > +  #SplitEmptyFunction: true # Unknown to clang-format-4.0
> > > +  #SplitEmptyRecord: true # Unknown to clang-format-4.0
> > > +  #SplitEmptyNamespace: true # Unknown to clang-format-4.0
> > > +BreakBeforeBinaryOperators: None
> > > +BreakBeforeBraces: Custom
> > > +#BreakBeforeInheritanceComma: false # Unknown to clang-format-4.0
> > > +BreakBeforeTernaryOperators: false
> > > +BreakConstructorInitializersBeforeComma: false
> > > +#BreakConstructorInitializers: BeforeComma # Unknown to clang-format-4.0
> > > +BreakAfterJavaFieldAnnotations: false
> > > +BreakStringLiterals: false
> > > +ColumnLimit: 80
> > > +CommentPragmas: '^ IWYU pragma:'
> > > +#CompactNamespaces: false # Unknown to clang-format-4.0
> > > +ConstructorInitializerAllOnOneLineOrOnePerLine: false
> > > +ConstructorInitializerIndentWidth: 8
> > > +ContinuationIndentWidth: 8
> > > +Cpp11BracedListStyle: false
> > > +DerivePointerAlignment: false
> > > +DisableFormat: false
> > > +ExperimentalAutoDetectBinPacking: false
> > > +#FixNamespaceComments: false # Unknown to clang-format-4.0
> > > +
> > > +# Taken from:
> > > +#   git grep -h '^#define [^[:space:]]*for_each[^[:space:]]*(' include/ \
> > > +#   | sed "s,^#define \([^[:space:]]*for_each[^[:space:]]*\)(.*$,  - '\1'," \
> > > +#   | sort | uniq
> >
> > Have you tried to run the command above, we don't have such extensive
> > list of macros on userspace:
> >
> > git grep -h '^#define [^[:space:]]*for_each[^[:space:]]*(' . | sed
> > "s,^#define \([^[:space:]]*for_each[^[:space:]]*\)(.*$,  - '\1'," |
> > sort | uniq
> >   - 'for_each_opt'
>
> I took this directly from the linux kernel repository and changed
> nothing. I would rather not change it unless we find it breaking
> formatting in bluez. Makes it easier to merge any updates the kernel
> may make.

That is a good point, though our codying style sometimes is not 1:1
with kernel, for instance the kernel allows to use spaces to align
multiline statements, etc, also note that for_each_opt is not in the
list bellow so I guess it is inevitable that we would end up with
different content.

> >
> > > +ForEachMacros:
> > > +  - 'apei_estatus_for_each_section'
> > > +  - 'ata_for_each_dev'
> > > +  - 'ata_for_each_link'
> > > +  - '__ata_qc_for_each'
> > > +  - 'ata_qc_for_each'
> > > +  - 'ata_qc_for_each_raw'
> > > +  - 'ata_qc_for_each_with_internal'
> > > +  - 'ax25_for_each'
> > > +  - 'ax25_uid_for_each'
> > > +  - '__bio_for_each_bvec'
> > > +  - 'bio_for_each_bvec'
> > > +  - 'bio_for_each_integrity_vec'
> > > +  - '__bio_for_each_segment'
> > > +  - 'bio_for_each_segment'
> > > +  - 'bio_for_each_segment_all'
> > > +  - 'bio_list_for_each'
> > > +  - 'bip_for_each_vec'
> > > +  - 'bitmap_for_each_clear_region'
> > > +  - 'bitmap_for_each_set_region'
> > > +  - 'blkg_for_each_descendant_post'
> > > +  - 'blkg_for_each_descendant_pre'
> > > +  - 'blk_queue_for_each_rl'
> > > +  - 'bond_for_each_slave'
> > > +  - 'bond_for_each_slave_rcu'
> > > +  - 'bpf_for_each_spilled_reg'
> > > +  - 'btree_for_each_safe128'
> > > +  - 'btree_for_each_safe32'
> > > +  - 'btree_for_each_safe64'
> > > +  - 'btree_for_each_safel'
> > > +  - 'card_for_each_dev'
> > > +  - 'cgroup_taskset_for_each'
> > > +  - 'cgroup_taskset_for_each_leader'
> > > +  - 'cpufreq_for_each_entry'
> > > +  - 'cpufreq_for_each_entry_idx'
> > > +  - 'cpufreq_for_each_valid_entry'
> > > +  - 'cpufreq_for_each_valid_entry_idx'
> > > +  - 'css_for_each_child'
> > > +  - 'css_for_each_descendant_post'
> > > +  - 'css_for_each_descendant_pre'
> > > +  - 'device_for_each_child_node'
> > > +  - 'dma_fence_chain_for_each'
> > > +  - 'drm_atomic_crtc_for_each_plane'
> > > +  - 'drm_atomic_crtc_state_for_each_plane'
> > > +  - 'drm_atomic_crtc_state_for_each_plane_state'
> > > +  - 'drm_atomic_for_each_plane_damage'
> > > +  - 'drm_client_for_each_connector_iter'
> > > +  - 'drm_client_for_each_modeset'
> > > +  - 'drm_connector_for_each_possible_encoder'
> > > +  - 'drm_for_each_bridge_in_chain'
> > > +  - 'drm_for_each_connector_iter'
> > > +  - 'drm_for_each_crtc'
> > > +  - 'drm_for_each_encoder'
> > > +  - 'drm_for_each_encoder_mask'
> > > +  - 'drm_for_each_fb'
> > > +  - 'drm_for_each_legacy_plane'
> > > +  - 'drm_for_each_plane'
> > > +  - 'drm_for_each_plane_mask'
> > > +  - 'drm_for_each_privobj'
> > > +  - 'drm_mm_for_each_hole'
> > > +  - 'drm_mm_for_each_node'
> > > +  - 'drm_mm_for_each_node_in_range'
> > > +  - 'drm_mm_for_each_node_safe'
> > > +  - 'flow_action_for_each'
> > > +  - 'for_each_active_dev_scope'
> > > +  - 'for_each_active_drhd_unit'
> > > +  - 'for_each_active_iommu'
> > > +  - 'for_each_available_child_of_node'
> > > +  - 'for_each_bio'
> > > +  - 'for_each_board_func_rsrc'
> > > +  - 'for_each_bvec'
> > > +  - 'for_each_card_auxs'
> > > +  - 'for_each_card_auxs_safe'
> > > +  - 'for_each_card_components'
> > > +  - 'for_each_card_pre_auxs'
> > > +  - 'for_each_card_prelinks'
> > > +  - 'for_each_card_rtds'
> > > +  - 'for_each_card_rtds_safe'
> > > +  - 'for_each_cgroup_storage_type'
> > > +  - 'for_each_child_of_node'
> > > +  - 'for_each_clear_bit'
> > > +  - 'for_each_clear_bit_from'
> > > +  - 'for_each_cmsghdr'
> > > +  - 'for_each_compatible_node'
> > > +  - 'for_each_component_dais'
> > > +  - 'for_each_component_dais_safe'
> > > +  - 'for_each_comp_order'
> > > +  - 'for_each_console'
> > > +  - 'for_each_cpu'
> > > +  - 'for_each_cpu_and'
> > > +  - 'for_each_cpu_not'
> > > +  - 'for_each_cpu_wrap'
> > > +  - 'for_each_dev_addr'
> > > +  - 'for_each_dev_scope'
> > > +  - 'for_each_displayid_db'
> > > +  - 'for_each_dma_cap_mask'
> > > +  - 'for_each_dpcm_be'
> > > +  - 'for_each_dpcm_be_rollback'
> > > +  - 'for_each_dpcm_be_safe'
> > > +  - 'for_each_dpcm_fe'
> > > +  - 'for_each_drhd_unit'
> > > +  - 'for_each_dss_dev'
> > > +  - 'for_each_efi_handle'
> > > +  - 'for_each_efi_memory_desc'
> > > +  - 'for_each_efi_memory_desc_in_map'
> > > +  - 'for_each_element'
> > > +  - 'for_each_element_extid'
> > > +  - 'for_each_element_id'
> > > +  - 'for_each_endpoint_of_node'
> > > +  - 'for_each_evictable_lru'
> > > +  - 'for_each_fib6_node_rt_rcu'
> > > +  - 'for_each_fib6_walker_rt'
> > > +  - 'for_each_free_mem_pfn_range_in_zone'
> > > +  - 'for_each_free_mem_pfn_range_in_zone_from'
> > > +  - 'for_each_free_mem_range'
> > > +  - 'for_each_free_mem_range_reverse'
> > > +  - 'for_each_func_rsrc'
> > > +  - 'for_each_hstate'
> > > +  - 'for_each_if'
> > > +  - 'for_each_iommu'
> > > +  - 'for_each_ip_tunnel_rcu'
> > > +  - 'for_each_irq_nr'
> > > +  - 'for_each_link_codecs'
> > > +  - 'for_each_link_platforms'
> > > +  - 'for_each_lru'
> > > +  - 'for_each_matching_node'
> > > +  - 'for_each_matching_node_and_match'
> > > +  - 'for_each_member'
> > > +  - 'for_each_memblock'
> > > +  - 'for_each_memblock_type'
> > > +  - 'for_each_memcg_cache_index'
> > > +  - 'for_each_mem_pfn_range'
> > > +  - 'for_each_mem_range'
> > > +  - 'for_each_mem_range_rev'
> > > +  - 'for_each_migratetype_order'
> > > +  - 'for_each_msi_entry'
> > > +  - 'for_each_msi_entry_safe'
> > > +  - 'for_each_net'
> > > +  - 'for_each_net_continue_reverse'
> > > +  - 'for_each_netdev'
> > > +  - 'for_each_netdev_continue'
> > > +  - 'for_each_netdev_continue_rcu'
> > > +  - 'for_each_netdev_continue_reverse'
> > > +  - 'for_each_netdev_feature'
> > > +  - 'for_each_netdev_in_bond_rcu'
> > > +  - 'for_each_netdev_rcu'
> > > +  - 'for_each_netdev_reverse'
> > > +  - 'for_each_netdev_safe'
> > > +  - 'for_each_net_rcu'
> > > +  - 'for_each_new_connector_in_state'
> > > +  - 'for_each_new_crtc_in_state'
> > > +  - 'for_each_new_mst_mgr_in_state'
> > > +  - 'for_each_new_plane_in_state'
> > > +  - 'for_each_new_private_obj_in_state'
> > > +  - 'for_each_node'
> > > +  - 'for_each_node_by_name'
> > > +  - 'for_each_node_by_type'
> > > +  - 'for_each_node_mask'
> > > +  - 'for_each_node_state'
> > > +  - 'for_each_node_with_cpus'
> > > +  - 'for_each_node_with_property'
> > > +  - 'for_each_of_allnodes'
> > > +  - 'for_each_of_allnodes_from'
> > > +  - 'for_each_of_cpu_node'
> > > +  - 'for_each_of_pci_range'
> > > +  - 'for_each_old_connector_in_state'
> > > +  - 'for_each_old_crtc_in_state'
> > > +  - 'for_each_old_mst_mgr_in_state'
> > > +  - 'for_each_oldnew_connector_in_state'
> > > +  - 'for_each_oldnew_crtc_in_state'
> > > +  - 'for_each_oldnew_mst_mgr_in_state'
> > > +  - 'for_each_oldnew_plane_in_state'
> > > +  - 'for_each_oldnew_plane_in_state_reverse'
> > > +  - 'for_each_oldnew_private_obj_in_state'
> > > +  - 'for_each_old_plane_in_state'
> > > +  - 'for_each_old_private_obj_in_state'
> > > +  - 'for_each_online_cpu'
> > > +  - 'for_each_online_node'
> > > +  - 'for_each_online_pgdat'
> > > +  - 'for_each_pci_bridge'
> > > +  - 'for_each_pci_dev'
> > > +  - 'for_each_pci_msi_entry'
> > > +  - 'for_each_populated_zone'
> > > +  - 'for_each_possible_cpu'
> > > +  - 'for_each_present_cpu'
> > > +  - 'for_each_prime_number'
> > > +  - 'for_each_prime_number_from'
> > > +  - 'for_each_process'
> > > +  - 'for_each_process_thread'
> > > +  - 'for_each_property_of_node'
> > > +  - 'for_each_registered_fb'
> > > +  - 'for_each_reserved_mem_region'
> > > +  - 'for_each_rtd_codec_dai'
> > > +  - 'for_each_rtd_codec_dai_rollback'
> > > +  - 'for_each_rtd_components'
> > > +  - 'for_each_set_bit'
> > > +  - 'for_each_set_bit_from'
> > > +  - 'for_each_set_clump8'
> > > +  - 'for_each_sg'
> > > +  - 'for_each_sg_dma_page'
> > > +  - 'for_each_sg_page'
> > > +  - 'for_each_sibling_event'
> > > +  - 'for_each_subelement'
> > > +  - 'for_each_subelement_extid'
> > > +  - 'for_each_subelement_id'
> > > +  - '__for_each_thread'
> > > +  - 'for_each_thread'
> > > +  - 'for_each_wakeup_source'
> > > +  - 'for_each_zone'
> > > +  - 'for_each_zone_zonelist'
> > > +  - 'for_each_zone_zonelist_nodemask'
> > > +  - 'fwnode_for_each_available_child_node'
> > > +  - 'fwnode_for_each_child_node'
> > > +  - 'fwnode_graph_for_each_endpoint'
> > > +  - 'gadget_for_each_ep'
> > > +  - 'genradix_for_each'
> > > +  - 'genradix_for_each_from'
> > > +  - 'hash_for_each'
> > > +  - 'hash_for_each_possible'
> > > +  - 'hash_for_each_possible_rcu'
> > > +  - 'hash_for_each_possible_rcu_notrace'
> > > +  - 'hash_for_each_possible_safe'
> > > +  - 'hash_for_each_rcu'
> > > +  - 'hash_for_each_safe'
> > > +  - 'hctx_for_each_ctx'
> > > +  - 'hlist_bl_for_each_entry'
> > > +  - 'hlist_bl_for_each_entry_rcu'
> > > +  - 'hlist_bl_for_each_entry_safe'
> > > +  - 'hlist_for_each'
> > > +  - 'hlist_for_each_entry'
> > > +  - 'hlist_for_each_entry_continue'
> > > +  - 'hlist_for_each_entry_continue_rcu'
> > > +  - 'hlist_for_each_entry_continue_rcu_bh'
> > > +  - 'hlist_for_each_entry_from'
> > > +  - 'hlist_for_each_entry_from_rcu'
> > > +  - 'hlist_for_each_entry_rcu'
> > > +  - 'hlist_for_each_entry_rcu_bh'
> > > +  - 'hlist_for_each_entry_rcu_notrace'
> > > +  - 'hlist_for_each_entry_safe'
> > > +  - '__hlist_for_each_rcu'
> > > +  - 'hlist_for_each_safe'
> > > +  - 'hlist_nulls_for_each_entry'
> > > +  - 'hlist_nulls_for_each_entry_from'
> > > +  - 'hlist_nulls_for_each_entry_rcu'
> > > +  - 'hlist_nulls_for_each_entry_safe'
> > > +  - 'i3c_bus_for_each_i2cdev'
> > > +  - 'i3c_bus_for_each_i3cdev'
> > > +  - 'ide_host_for_each_port'
> > > +  - 'ide_port_for_each_dev'
> > > +  - 'ide_port_for_each_present_dev'
> > > +  - 'idr_for_each_entry'
> > > +  - 'idr_for_each_entry_continue'
> > > +  - 'idr_for_each_entry_continue_ul'
> > > +  - 'idr_for_each_entry_ul'
> > > +  - 'in_dev_for_each_ifa_rcu'
> > > +  - 'in_dev_for_each_ifa_rtnl'
> > > +  - 'inet_bind_bucket_for_each'
> > > +  - 'inet_lhash2_for_each_icsk_rcu'
> > > +  - 'key_for_each'
> > > +  - 'key_for_each_safe'
> > > +  - 'klp_for_each_func'
> > > +  - 'klp_for_each_func_safe'
> > > +  - 'klp_for_each_func_static'
> > > +  - 'klp_for_each_object'
> > > +  - 'klp_for_each_object_safe'
> > > +  - 'klp_for_each_object_static'
> > > +  - 'kvm_for_each_memslot'
> > > +  - 'kvm_for_each_vcpu'
> > > +  - 'list_for_each'
> > > +  - 'list_for_each_codec'
> > > +  - 'list_for_each_codec_safe'
> > > +  - 'list_for_each_continue'
> > > +  - 'list_for_each_entry'
> > > +  - 'list_for_each_entry_continue'
> > > +  - 'list_for_each_entry_continue_rcu'
> > > +  - 'list_for_each_entry_continue_reverse'
> > > +  - 'list_for_each_entry_from'
> > > +  - 'list_for_each_entry_from_rcu'
> > > +  - 'list_for_each_entry_from_reverse'
> > > +  - 'list_for_each_entry_lockless'
> > > +  - 'list_for_each_entry_rcu'
> > > +  - 'list_for_each_entry_reverse'
> > > +  - 'list_for_each_entry_safe'
> > > +  - 'list_for_each_entry_safe_continue'
> > > +  - 'list_for_each_entry_safe_from'
> > > +  - 'list_for_each_entry_safe_reverse'
> > > +  - 'list_for_each_prev'
> > > +  - 'list_for_each_prev_safe'
> > > +  - 'list_for_each_safe'
> > > +  - 'llist_for_each'
> > > +  - 'llist_for_each_entry'
> > > +  - 'llist_for_each_entry_safe'
> > > +  - 'llist_for_each_safe'
> > > +  - 'mci_for_each_dimm'
> > > +  - 'media_device_for_each_entity'
> > > +  - 'media_device_for_each_intf'
> > > +  - 'media_device_for_each_link'
> > > +  - 'media_device_for_each_pad'
> > > +  - 'nanddev_io_for_each_page'
> > > +  - 'netdev_for_each_lower_dev'
> > > +  - 'netdev_for_each_lower_private'
> > > +  - 'netdev_for_each_lower_private_rcu'
> > > +  - 'netdev_for_each_mc_addr'
> > > +  - 'netdev_for_each_uc_addr'
> > > +  - 'netdev_for_each_upper_dev_rcu'
> > > +  - 'netdev_hw_addr_list_for_each'
> > > +  - 'nft_rule_for_each_expr'
> > > +  - 'nla_for_each_attr'
> > > +  - 'nla_for_each_nested'
> > > +  - 'nlmsg_for_each_attr'
> > > +  - 'nlmsg_for_each_msg'
> > > +  - 'nr_neigh_for_each'
> > > +  - 'nr_neigh_for_each_safe'
> > > +  - 'nr_node_for_each'
> > > +  - 'nr_node_for_each_safe'
> > > +  - 'of_for_each_phandle'
> > > +  - 'of_property_for_each_string'
> > > +  - 'of_property_for_each_u32'
> > > +  - 'pci_bus_for_each_resource'
> > > +  - 'ping_portaddr_for_each_entry'
> > > +  - 'plist_for_each'
> > > +  - 'plist_for_each_continue'
> > > +  - 'plist_for_each_entry'
> > > +  - 'plist_for_each_entry_continue'
> > > +  - 'plist_for_each_entry_safe'
> > > +  - 'plist_for_each_safe'
> > > +  - 'pnp_for_each_card'
> > > +  - 'pnp_for_each_dev'
> > > +  - 'protocol_for_each_card'
> > > +  - 'protocol_for_each_dev'
> > > +  - 'queue_for_each_hw_ctx'
> > > +  - 'radix_tree_for_each_slot'
> > > +  - 'radix_tree_for_each_tagged'
> > > +  - 'rbtree_postorder_for_each_entry_safe'
> > > +  - 'rdma_for_each_block'
> > > +  - 'rdma_for_each_port'
> > > +  - 'resource_list_for_each_entry'
> > > +  - 'resource_list_for_each_entry_safe'
> > > +  - 'rhl_for_each_entry_rcu'
> > > +  - 'rhl_for_each_rcu'
> > > +  - 'rht_for_each'
> > > +  - 'rht_for_each_entry'
> > > +  - 'rht_for_each_entry_from'
> > > +  - 'rht_for_each_entry_rcu'
> > > +  - 'rht_for_each_entry_rcu_from'
> > > +  - 'rht_for_each_entry_safe'
> > > +  - 'rht_for_each_from'
> > > +  - 'rht_for_each_rcu'
> > > +  - 'rht_for_each_rcu_from'
> > > +  - '__rq_for_each_bio'
> > > +  - 'rq_for_each_bvec'
> > > +  - 'rq_for_each_segment'
> > > +  - 'scsi_for_each_prot_sg'
> > > +  - 'scsi_for_each_sg'
> > > +  - 'sctp_for_each_hentry'
> > > +  - 'sctp_skb_for_each'
> > > +  - 'shdma_for_each_chan'
> > > +  - '__shost_for_each_device'
> > > +  - 'shost_for_each_device'
> > > +  - 'sk_for_each'
> > > +  - 'sk_for_each_bound'
> > > +  - 'sk_for_each_entry_offset_rcu'
> > > +  - 'sk_for_each_from'
> > > +  - 'sk_for_each_rcu'
> > > +  - 'sk_for_each_safe'
> > > +  - 'sk_nulls_for_each'
> > > +  - 'sk_nulls_for_each_from'
> > > +  - 'sk_nulls_for_each_rcu'
> > > +  - 'snd_array_for_each'
> > > +  - 'snd_pcm_group_for_each_entry'
> > > +  - 'snd_soc_dapm_widget_for_each_path'
> > > +  - 'snd_soc_dapm_widget_for_each_path_safe'
> > > +  - 'snd_soc_dapm_widget_for_each_sink_path'
> > > +  - 'snd_soc_dapm_widget_for_each_source_path'
> > > +  - 'tb_property_for_each'
> > > +  - 'tcf_exts_for_each_action'
> > > +  - 'udp_portaddr_for_each_entry'
> > > +  - 'udp_portaddr_for_each_entry_rcu'
> > > +  - 'usb_hub_for_each_child'
> > > +  - 'v4l2_device_for_each_subdev'
> > > +  - 'v4l2_m2m_for_each_dst_buf'
> > > +  - 'v4l2_m2m_for_each_dst_buf_safe'
> > > +  - 'v4l2_m2m_for_each_src_buf'
> > > +  - 'v4l2_m2m_for_each_src_buf_safe'
> > > +  - 'virtio_device_for_each_vq'
> > > +  - 'xa_for_each'
> > > +  - 'xa_for_each_marked'
> > > +  - 'xa_for_each_range'
> > > +  - 'xa_for_each_start'
> > > +  - 'xas_for_each'
> > > +  - 'xas_for_each_conflict'
> > > +  - 'xas_for_each_marked'
> > > +  - 'xbc_array_for_each_value'
> > > +  - 'xbc_for_each_key_value'
> > > +  - 'xbc_node_for_each_array_value'
> > > +  - 'xbc_node_for_each_child'
> > > +  - 'xbc_node_for_each_key_value'
> > > +  - 'zorro_for_each_dev'
> > > +
> > > +#IncludeBlocks: Preserve # Unknown to clang-format-5.0
> > > +IncludeCategories:
> > > +  - Regex: '.*'
> > > +    Priority: 1
> > > +IncludeIsMainRegex: '(Test)?$'
> > > +IndentCaseLabels: false
> > > +#IndentPPDirectives: None # Unknown to clang-format-5.0
> > > +IndentWidth: 8
> > > +IndentWrappedFunctionNames: false
> > > +JavaScriptQuotes: Leave
> > > +JavaScriptWrapImports: true
> > > +KeepEmptyLinesAtTheStartOfBlocks: false
> > > +MacroBlockBegin: ''
> > > +MacroBlockEnd: ''
> > > +MaxEmptyLinesToKeep: 1
> > > +NamespaceIndentation: Inner
> > > +#ObjCBinPackProtocolList: Auto # Unknown to clang-format-5.0
> > > +ObjCBlockIndentWidth: 8
> > > +ObjCSpaceAfterProperty: true
> > > +ObjCSpaceBeforeProtocolList: true
> > > +
> > > +# Taken from git's rules
> > > +#PenaltyBreakAssignment: 10 # Unknown to clang-format-4.0
> > > +PenaltyBreakBeforeFirstCallParameter: 30
> > > +PenaltyBreakComment: 10
> > > +PenaltyBreakFirstLessLess: 0
> > > +PenaltyBreakString: 10
> > > +PenaltyExcessCharacter: 100
> > > +PenaltyReturnTypeOnItsOwnLine: 60
> > > +
> > > +PointerAlignment: Right
> > > +ReflowComments: false
> > > +SortIncludes: false
> > > +#SortUsingDeclarations: false # Unknown to clang-format-4.0
> > > +SpaceAfterCStyleCast: false
> > > +SpaceAfterTemplateKeyword: true
> > > +SpaceBeforeAssignmentOperators: true
> > > +#SpaceBeforeCtorInitializerColon: true # Unknown to clang-format-5.0
> > > +#SpaceBeforeInheritanceColon: true # Unknown to clang-format-5.0
> > > +SpaceBeforeParens: ControlStatements
> > > +#SpaceBeforeRangeBasedForLoopColon: true # Unknown to clang-format-5.0
> > > +SpaceInEmptyParentheses: false
> > > +SpacesBeforeTrailingComments: 1
> > > +SpacesInAngles: false
> > > +SpacesInContainerLiterals: false
> > > +SpacesInCStyleCastParentheses: false
> > > +SpacesInParentheses: false
> > > +SpacesInSquareBrackets: false
> > > +Standard: Cpp03
> > > +TabWidth: 8
> > > +UseTab: Always
> > > +...
> > > --
> > > 2.26.1.301.g55bc3eb7cb9-goog
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
